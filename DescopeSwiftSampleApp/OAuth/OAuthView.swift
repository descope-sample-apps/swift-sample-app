//
//  OAuthView.swift
//  LoginScreenDemo
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit
import AuthenticationServices

struct OAuthView: View {
    let verticalPaddingForForm = 20.0
    @State var isLoggedIn: Bool = false
    @StateObject var viewModel = OAuthLoginSession()
    @State var resultError: DescopeError?
    @State var showAlert: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Sign In with Social login")
                        .font(.title)
                        .foregroundColor(Color.white)
                    
                    
                    
                    HStack {
                        Button(action: {
                            Task.init {
                                try await self.viewModel.OAuthLogin(provider: OAuthProvider.google, context: self.viewModel) { result, error in
                                    isLoggedIn.toggle()
                                }
                                    }
                               }) {
                                    Text("Google")
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
                        
                        Button(action: {
                            Task.init {
                                try await self.viewModel.OAuthLogin(provider: OAuthProvider.facebook, context: self.viewModel) { result, error in
                                    isLoggedIn.toggle()
                                }
                                    }
                               }) {
                                    Text("Facebook")
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
                    
                    NavigationLink(destination: LoggedInView(loginId: "OAuth").navigationBarBackButtonHidden(true), isActive: $isLoggedIn) {}
                    
                    
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

struct OAuthView_Previews: PreviewProvider {
    static var previews: some View {
        OAuthView()
    }
}

