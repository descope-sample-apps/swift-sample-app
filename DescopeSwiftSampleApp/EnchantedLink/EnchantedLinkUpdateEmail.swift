//
//  EnchantedLinkUpdateEmail.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct EnchantedLinkUpdateEmail: View {
    @State var loginId: String = ""
    @State var userEmail: String = ""
    let verticalPaddingForForm = 20.0
    @State var initiated: Bool = false
    @State var showAlert: Bool = false
    @State var resultError: DescopeError?
    @State var enchantedResp: EnchantedLinkResponse?
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
                    
                    HStack {
                        Button(action: {
                            Task.init {
                                try await enchantedLinkUpdateEmail(loginId: loginId, email: userEmail) { result, response, error in
                                    resultError = error
                                    enchantedResp = response
                                    if result == true{
                                        initiated.toggle()
                                    }
                                    else {
                                        showAlert = true
                                    }
                                }
                                    }
                               }) {
                                    Text("Enchanted Link Update Email")
                                }.padding()
                            .background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("Enchanted Link Email Update Failed"),
                                        message: Text((resultError!.errorDescription!))
                                    )
                                }
                    }
                    
                    NavigationLink(destination: EnchantedLinkDisplayView(loginId: loginId, enchantedId: enchantedResp?.linkId ?? "x").navigationBarHidden(true).navigationBarTitle("").navigationBarBackButtonHidden(true), isActive: $initiated) { }

                    
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

struct EnchantedLinkUpdateEmail_Previews: PreviewProvider {
    static var previews: some View {
        EnchantedLinkUpdateEmail(loginId: String())
    }
}
