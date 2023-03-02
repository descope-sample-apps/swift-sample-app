//
//  SignUpView.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct SignUpOTP: View {
    @State var loginId: String = ""
    @State var userPhone: String = ""
    @State var name: String = ""
    @State var method: String = ""
    @State var initiated: Bool = false
    @State var showAlert: Bool = false
    @State var resultError: DescopeError?
    let verticalPaddingForForm = 20.0
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Sign Up In App")
                        .font(.title)
                        .foregroundColor(Color.white)
                    HStack {
                        TextField("Enter your Name", text: $name)
                            .foregroundColor(Color.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack {
                        TextField("Enter your Email", text: $loginId)
                            .foregroundColor(Color.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack {
                        TextField("Enter your Phone Number", text: $userPhone)
                            .foregroundColor(Color.black)
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack {
                         Button(action: {
                             Task.init {
                                 method = "email"
                                 try await otpSignUp(userEmail: loginId, loginId: loginId, userPhone:userPhone, name:name, method:method) { result, error in
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
                                         title: Text("Failed Signup"),
                                         message: Text((resultError!.errorDescription!))
                                     )
                                 }
                         Button(action: {
                             Task.init {
                                 method = "sms"
                                 try await otpSignUp(userEmail: loginId, loginId: loginId, userPhone:userPhone, name:name, method:method) { result, error in
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
                                         title: Text("Failed Signup"),
                                         message: Text((resultError!.errorDescription!))
                                     )
                                 }
                    }
                    .padding()
                    .cornerRadius(10)
                    
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

struct SignUpOTP_Previews: PreviewProvider {
    static var previews: some View {
        SignUpOTP()
    }
}
