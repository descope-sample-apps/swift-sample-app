//
//  SignUpView.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct SignInPasswords: View {
    @State var loginId: String = ""
    @State var userPhone: String = ""
    @State var userPassword: String = ""
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
                    Text("Sign In")
                        .font(.title)
                        .foregroundColor(Color.white)
                    
                    HStack {
                        TextField("Enter your Email", text: $loginId)
                            .foregroundColor(Color.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack {
                        SecureField("Enter your Password", text: $userPassword)
                            .foregroundColor(Color.black)
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack {
                         Button(action: {
                             Task.init {
                                 try await passwordsSignIn(userPassword: userPassword, loginId: loginId, method:method) { result, error in
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
                                     Text("Sign In")
                                 }.padding()
                             .background(Color.black)
                             .foregroundColor(Color.white)
                             .cornerRadius(10)
                             .alert(isPresented: $showAlert) {
                                     Alert(
                                         title: Text("Failed Signin"),
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

struct SignInPasswords_Previews: PreviewProvider {
    static var previews: some View {
        SignInPasswords()
    }
}
