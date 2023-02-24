//
//  TOTPLoggedInView.swift
//  LoginScreenDemo
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct TOTPLoggedInView: View {
    @State  var loginId: String
    let verticalPaddingForForm = 20.0
    // @State var loggedInUserName: String
    @State var initiated: Bool = false
    @State var showAlert: Bool = false
    @State var resultError: DescopeError?
    @State var totpResponse: TOTPResponse?
    @State var thisImage: UIImage?
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Successfully Signed In " + loginId)
                        .font(.title)
                        .foregroundColor(Color.white)
                    
                    HStack {
                        Button(action: {
                            Task.init {
                                try await totpUpdate(loginId: loginId) { result, response, error in
                                    resultError = error
                                    totpResponse = response
                                    if result == true{
                                        thisImage = totpResponse!.image
                                        initiated.toggle()
                                    }
                                    else {
                                        showAlert = true
                                    }
                                }
                                    }
                               }) {
                                    Text("Update TOTP")
                                }.padding()
                            .background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("TOTP Update Failed"),
                                        message: Text((resultError!.errorDescription!))
                                    )
                                }
                    }
                    
                    NavigationLink(destination: TOTPDisplayView(loginId: loginId, totpImage: thisImage ?? UIImage(), totpKey:totpResponse?.key ?? "XYZ").navigationBarHidden(true).navigationBarTitle("").navigationBarBackButtonHidden(true), isActive: $initiated) { }

                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                        Text("Back to home screen")
                            .padding()
                    }
                    .background(Color.black)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    // Handle logout
                }.padding(.horizontal, CGFloat(verticalPaddingForForm))
            }
        };
    }
}

struct TOTPLoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        TOTPLoggedInView(loginId: String())
    }
}
