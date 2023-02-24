//
//  TOTPVerifyView.swift
//  LoginScreenDemo
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct TOTPVerifyView: View {
    @State var loginId: String
    @State private var verifyCode: String = ""
    let verticalPaddingForForm = 20.0
    @State var isLoggedIn: Bool = false
    @State var showAlert: Bool = false
    @State var resultError: DescopeError?
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
            VStack(spacing: CGFloat(verticalPaddingForForm)) {
                Text("Verify TOTP Code")
                    .font(.title)
                    .foregroundColor(Color.white)
                
                HStack {
                    TextField("Enter your TOTP code", text: $verifyCode)
                        .foregroundColor(Color.black)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                
                HStack {
                    Button(action: {
                        Task.init {
                            try await totpVerify(verifyCode: verifyCode, loginId: loginId) { result, error in
                                resultError = error
                                if result == true{
                                    isLoggedIn.toggle()
                                }
                                else {
                                    showAlert = true
                                }
                            }
                                }
                           }) {
                                Text("Verify TOTP")
                            }.padding()
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("TOTP Verification Failed"),
                                    message: Text((resultError!.errorDescription!))
                                )
                            }
                }
                
                NavigationLink(destination: TOTPLoggedInView(loginId: loginId).navigationBarHidden(true).navigationBarTitle("").navigationBarBackButtonHidden(true), isActive: $isLoggedIn) { }
                
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                    Text("Back to home screen")
                        .padding()
                }
                .background(Color.black)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                
            }.padding(.horizontal, CGFloat(verticalPaddingForForm))
        }
    }
}

struct TOTPVerifyView_Previews: PreviewProvider {
    static var previews: some View {
        TOTPVerifyView(loginId: String())
    }
}
