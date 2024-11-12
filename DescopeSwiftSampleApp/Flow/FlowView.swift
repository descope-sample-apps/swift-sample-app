import SwiftUI
import DescopeKit

struct FlowView: View {
    @State private var showAlert = false
    @State private var resultError: DescopeError?
    @State private var initiated = false

    private let localProjectId = Bundle.main.infoDictionary!["myProjectId"] as! String

    var flowURL: URL {
        URL(string: "https://auth.descope.io/P2olPnHNRIPqvZv63AfaxFAXTp0C?flow=sign-up-or-in")!
    }

    var body: some View {
        NavigationView {
            VStack {
                if !initiated {
                    DescopeFlowViewRepresentable(
                        flowURL: flowURL,
                        onFlowFinish: handleFlowFinish,
                        onFlowError: handleFlowError
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("Authentication Successful!")
                        .font(.largeTitle)
                        .padding()
                }
                
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                    Text("Back to Home Screen")
                        .padding()
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Authentication Error"),
                    message: Text(resultError?.errorDescription ?? "An error occurred"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    private func handleFlowFinish(response: AuthenticationResponse) {
        let session = DescopeSession(from: response)
        Descope.sessionManager.manageSession(session)
        initiated = true
    }

    private func handleFlowError(error: DescopeError) {
        resultError = error
        showAlert = true
    }
}


class FlowDelegateHandler: NSObject, DescopeFlowViewControllerDelegate {
    var onFlowFinish: ((AuthenticationResponse) -> Void)?
    var onFlowError: ((DescopeError) -> Void)?
    var onFlowUpdateState: ((DescopeFlowState, DescopeFlowState) -> Void)?
    var onFlowReady: (() -> Void)?
    var onFlowCancel: (() -> Void)?
    var onShowURL: ((URL, Bool) -> Bool)?

    func flowViewControllerDidUpdateState(_ controller: DescopeFlowViewController, to state: DescopeFlowState, from previous: DescopeFlowState) {
        onFlowUpdateState?(state, previous)
    }
    
    func flowViewControllerDidBecomeReady(_ controller: DescopeFlowViewController) {
        onFlowReady?()
    }
    
    func flowViewControllerShouldShowURL(_ controller: DescopeFlowViewController, url: URL, external: Bool) -> Bool {
        return onShowURL?(url, external) ?? true
    }
    
    func flowViewControllerDidCancel(_ controller: DescopeFlowViewController) {
        onFlowCancel?()
    }
    
    func flowViewControllerDidFail(_ controller: DescopeFlowViewController, error: DescopeError) {
        onFlowError?(error)
    }
    
    func flowViewControllerDidFinish(_ controller: DescopeFlowViewController, response: AuthenticationResponse) {
        onFlowFinish?(response)
    }
}




struct DescopeFlowViewRepresentable: UIViewRepresentable {
    let flowURL: URL
    let onFlowFinish: (AuthenticationResponse) -> Void
    let onFlowError: (DescopeError) -> Void

    func makeUIView(context: Context) -> DescopeFlowView {
        let flowView = DescopeFlowView(frame: .zero)
        flowView.delegate = context.coordinator

        // Start the flow
        let flow = DescopeFlow(url: flowURL)
        flowView.start(flow: flow)

        return flowView
    }

    func updateUIView(_ uiView: DescopeFlowView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onFlowFinish: onFlowFinish, onFlowError: onFlowError)
    }

    class Coordinator: NSObject, DescopeFlowViewDelegate {
        let onFlowFinish: (AuthenticationResponse) -> Void
        let onFlowError: (DescopeError) -> Void

        init(onFlowFinish: @escaping (AuthenticationResponse) -> Void, onFlowError: @escaping (DescopeError) -> Void) {
            self.onFlowFinish = onFlowFinish
            self.onFlowError = onFlowError
        }

        func flowViewDidUpdateState(_ flowView: DescopeFlowView, to state: DescopeFlowState, from previous: DescopeFlowState) {
            // Handle state changes if needed
        }

        func flowViewDidBecomeReady(_ flowView: DescopeFlowView) {
            // Flow is ready to be displayed, handle any loading states if necessary
        }

        func flowViewDidInterceptNavigation(_ flowView: DescopeFlowView, url: URL, external: Bool) {
            // Open external URLs if necessary
            if external {
                UIApplication.shared.open(url)
            }
        }

        func flowViewDidFailAuthentication(_ flowView: DescopeFlowView, error: DescopeError) {
            onFlowError(error)
        }

        func flowViewDidFinishAuthentication(_ flowView: DescopeFlowView, response: AuthenticationResponse) {
            onFlowFinish(response)
        }
    }
}
