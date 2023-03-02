//
//  VerifyOTPView.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct VerifyOTPView: View {
    @State var loginId: String
    @State var method: String
    @State private var verifyCode: String = ""
    @State var isLoggedIn: Bool = false
    @State var showAlert: Bool = false
    @State var resultError: DescopeError?
    let verticalPaddingForForm = 20.0
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
            VStack(spacing: CGFloat(verticalPaddingForForm)) {
                Text("Verify your OTP Code")
                    .font(.title)
                    .foregroundColor(Color.white)
                HStack {
                    TextField("Enter your otp code", text: $verifyCode)
                        .foregroundColor(Color.black)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                
                    Button(action: {
                        Task.init {
                            try await otpVerify(verifyCode: verifyCode, loginId: loginId, method: method) { result, error in
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
                                Text("Verify OTP")
                            }.padding()
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("OTP Verification Failed"),
                                    message: Text((resultError!.errorDescription!))
                                )
                            }
                    
                
                NavigationLink(destination: OTPLoggedIn(loginId: loginId).navigationBarHidden(true).navigationBarTitle("").navigationBarBackButtonHidden(true), isActive: $isLoggedIn) { }
                
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

struct VerifyOTPView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyOTPView(loginId: String(), method: String())
    }
}
