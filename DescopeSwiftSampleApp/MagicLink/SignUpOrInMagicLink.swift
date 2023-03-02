//
//  SignUpOrInMagicLink.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct SignUpOrInMagicLink: View {
    @State var loginId: String = ""
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
                    
                    /*NavigationLink(destination: VerifyMagicLinkView(loginId:loginId, method: "email").navigationBarBackButtonHidden(true)) {
                        Text("Magic Link Email")
                            .padding()
                    }.background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .simultaneousGesture(TapGesture().onEnded{
                            magicLinkSignUpOrIn(loginId: loginId, method: "email")
                        })
                    
                    NavigationLink(destination: VerifyMagicLinkView(loginId:loginId, method: "SMS").navigationBarBackButtonHidden(true)) {
                        Text("Magic Link SMS")
                            .padding()
                    }.background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .simultaneousGesture(TapGesture().onEnded{
                            magicLinkSignUpOrIn(loginId: loginId, method: "sms")
                        })*/
                    
                    Button(action: {
                        Task.init {
                            method = "email"
                            try await magicLinkSignUpOrIn(loginId: loginId, method: method) { result, error in
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
                                    title: Text("Failed Sign up or in"),
                                    message: Text((resultError!.errorDescription!))
                                )
                            }
                    
                    
                    Button(action: {
                        Task.init {
                            method = "sms"
                            try await magicLinkSignUpOrIn(loginId: loginId, method: method) { result, error in
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
                                    title: Text("Failed Sign up or in"),
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

struct SignUpOrInMagicLink_Previews: PreviewProvider {
    static var previews: some View {
        SignUpOrInMagicLink()
    }
}
