//
//  SignUpMagicLink.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct SignUpMagicLink: View {
    @State var loginId: String = ""
    @State var userPhone: String = ""
    @State var name: String = ""
    @State var method: String = ""
    let verticalPaddingForForm = 20.0
    @State var initiated: Bool = false
    @State var showAlert: Bool = false
    @State var resultError: DescopeError?
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
                    
                    Button(action: {
                        Task.init {
                            method = "email"
                            try await magicLinkSignUp(userEmail: loginId, loginId: loginId, userPhone:userPhone, name:name, method:method) { result, error in
                                if result == true{
                                    initiated.toggle()
                                }
                                else {
                                    resultError = error
                                    showAlert = true
                                }
                            }
                                }
                           }) {
                                Text("Magic Link Emaill")
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
                            try await magicLinkSignUp(userEmail: loginId, loginId: loginId, userPhone:userPhone, name:name, method:method) { result, error in
                                if result == true{
                                    initiated.toggle()
                                }
                                else {
                                    resultError = error
                                    showAlert = true
                                }
                            }
                                }
                           }) {
                                Text("Magic Link SMS")
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
                    
                    NavigationLink(destination: VerifyMagicLinkView(loginId:loginId, method: method).navigationBarBackButtonHidden(true), isActive: $initiated) {}

                    
                    
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

struct SignUpMagicLink_Previews: PreviewProvider {
    static var previews: some View {
        SignUpMagicLink()
    }
}
