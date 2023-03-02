//
//  SSOView.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct SSOView: View {
    let verticalPaddingForForm = 20.0
    @State var userEmail: String = ""
    @State var isLoggedIn: Bool = false
    @StateObject var viewModel = SSOLoginSession()
    @State var resultError: DescopeError?
    @State var showAlert: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Sign In with SSO")
                        .font(.title)
                        .foregroundColor(Color.white)
                    
                    HStack {
                        TextField("Enter your Email", text: $userEmail)
                            .foregroundColor(Color.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    Button(action: {
                        Task.init {
                            try await self.viewModel.SSOLogin(email:userEmail, context: self.viewModel) { result, error in
                                isLoggedIn.toggle()
                            }        
                                }
                           }) {
                                Text("Log In")
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
                    
                    NavigationLink(destination: LoggedInView(loginId: userEmail).navigationBarHidden(true).navigationBarTitle("").navigationBarBackButtonHidden(true), isActive: $isLoggedIn) { }
                    
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

struct SSOView_Previews: PreviewProvider {
    static var previews: some View {
        SSOView()
    }
}
