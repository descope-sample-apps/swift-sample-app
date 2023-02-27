//
//  MagicLinkUpdateEmail.swift
//  LoginScreenDemo
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct MagicLinkUpdateEmail: View {
    @State var loginId: String = ""
    @State var method: String = ""
    @State var userEmail: String = ""
    let verticalPaddingForForm = 20.0
    @State var initiated: Bool = false
    @State var showAlert: Bool = false
    @State var resultError: DescopeError?
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Update Email")
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
                            method = "email"
                            try await magicLinkUpdateEmail(loginId: loginId, email: userEmail) { result, error in
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
                                Text("Magic Link Update Email")
                            }.padding()
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Failed to update email"),
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

struct MagicLinkUpdateEmail_Previews: PreviewProvider {
    static var previews: some View {
        MagicLinkUpdateEmail(loginId: String())
    }
}
