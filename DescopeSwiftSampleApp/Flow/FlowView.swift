//
//  SignUpView.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct FlowView: View {
    @State var initiated: Bool = false
    @State var showAlert: Bool = false
    @State var resultError: DescopeError?
    @State var loginId: String = "";
    var flowURL = "<web_hosted_page_flow_url>";
    let verticalPaddingForForm = 20.0
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Test out your Descope Flow")
                        .font(.title)
                        .foregroundColor(Color.white)
                   
                    HStack {
                         Button(action: {
                             Task.init {
                                 try await startFlow(flowURL: flowURL)
                                  { result, error in
                                     resultError = error
                                     if result == true{
                                         initiated.toggle()
                                     }
                                     else {
                                         showAlert = true
                                     }
                                 }
                                     }
                                }) {
                                     Text("Start Flow")
                                 }.padding()
                             .background(Color.black)
                             .foregroundColor(Color.white)
                             .cornerRadius(10)
                             .alert(isPresented: $showAlert) {
                                     Alert(
                                         title: Text("Failed Flow"),
                                         message: Text((resultError!.errorDescription!))
                                     )
                                 }
                    }
                    .padding()
                    .cornerRadius(10)
                    
                    NavigationLink(destination: PasswordsLoggedIn(loginId:loginId).navigationBarBackButtonHidden(true), isActive: $initiated) {
                    }
                    
                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                        Text("Back to home screen")
                            .padding()
                    }
                    .background(Color.black)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    
                }.padding(.horizontal, CGFloat(verticalPaddingForForm))
            }
        };
    }
}

struct FlowView_Previews: PreviewProvider {
    static var previews: some View {
        FlowView()
    }
}
