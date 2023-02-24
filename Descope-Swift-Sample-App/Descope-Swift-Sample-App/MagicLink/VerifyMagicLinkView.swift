//
//  VerifyMagicLinkView.swift
//  LoginScreenDemo
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct VerifyMagicLinkView: View {
    @State var loginId: String
    @State var method: String
    @State private var token: String = ""
    let verticalPaddingForForm = 20.0
    @State var isLoggedIn: Bool = false
    @State var showAlert: Bool = false
    @State var resultError: DescopeError?
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
            VStack(spacing: CGFloat(verticalPaddingForForm)) {
                Text("Verify your Magic Link Token")
                    .font(.title)
                    .foregroundColor(Color.white)
                HStack {
                    TextField("Enter your Magic Link Token", text: $token)
                        .foregroundColor(Color.black)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                
                HStack {
                    
                    Button(action: {
                        Task.init {
                            try await magicLinkVerify(token: token) { result, error in
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
                                Text("Verify Token")
                            }.padding()
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Token Verification Failed"),
                                    message: Text((resultError!.errorDescription!))
                                )
                            }
                    
                    NavigationLink(destination: MagicLinkLoggedIn(loginId: loginId).navigationBarHidden(true).navigationBarTitle("").navigationBarBackButtonHidden(true), isActive: $isLoggedIn) { }
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
    }
}

struct VerifyMagicLinkView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyMagicLinkView(loginId: String(), method: String())
    }
}
