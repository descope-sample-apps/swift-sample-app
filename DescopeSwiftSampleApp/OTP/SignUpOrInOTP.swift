//
//  SignUpOrInOTP.swift
//  LoginScreenDemo
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct SignUpOrInOTP: View {
    @State var loginId: String = ""
    let verticalPaddingForForm = 20.0
    @State var method: String = ""
    @State var initiated: Bool = false
    @State var showAlert: Bool = false
    @State var resultError: DescopeError?
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Sign Up or Into App")
                        .font(.title)
                        .foregroundColor(Color.white)
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.secondary)
                        TextField("Enter email or phone number", text: $loginId)
                            .foregroundColor(Color.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack {
                        Button(action: {
                            Task.init {
                                method = "email"
                                try await otpSignUpOrIn(loginId: loginId, method: method) { result, error in
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
                                    Text("OTP Email")
                                }.padding()
                            .background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("Failed Sign up or in"),
                                        message: Text((resultError!.errorDescription!))
                                    )
                                }
                        Button(action: {
                            Task.init {
                                method = "sms"
                                try await otpSignUpOrIn(loginId: loginId, method: method) { result, error in
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
                                    Text("OTP SMS")
                                }.padding()
                            .background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("Failed Sign up or in"),
                                        message: Text((resultError!.errorDescription!))
                                    )
                                }
                    }
                    
                    NavigationLink(destination: VerifyOTPView(loginId:loginId, method: method).navigationBarBackButtonHidden(true), isActive: $initiated) {
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

struct SignUpOrInOTP_Previews: PreviewProvider {
    static var previews: some View {
        SignUpOrInOTP()
    }
}
