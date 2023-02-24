//
//  MagicLinkUpdatePhone.swift
//  LoginScreenDemo
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct MagicLinkUpdatePhone: View {
    @State var loginId: String = ""
    @State var method: String = ""
    @State var userPhone: String = ""
    let verticalPaddingForForm = 20.0
    @State var initiated: Bool = false
    @State var showAlert: Bool = false
    @State var resultError: DescopeError?
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Update Phone via Magic Link")
                        .font(.title)
                        .foregroundColor(Color.white)
                    HStack {
                        TextField("Enter your phone number", text: $userPhone)
                            .foregroundColor(Color.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    Button(action: {
                        Task.init {
                            method = "sms"
                            try await magicLinkUpdatePhone(loginId: loginId, phone: userPhone, method: method) { result, error in
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
                                Text("Magic Link Update Phone")
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

struct MagicLinkUpdatePhone_Previews: PreviewProvider {
    static var previews: some View {
        MagicLinkUpdatePhone(loginId: String())
    }
}
