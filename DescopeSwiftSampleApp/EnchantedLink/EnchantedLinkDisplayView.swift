//
//  EnchantedLinkDisplayView.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct EnchantedLinkDisplayView: View {
    @State var loginId: String
    @State var enchantedId: String
    let verticalPaddingForForm = 20.0
    @State var isLoggedIn: Bool = false
    @State var showAlert: Bool = false
    @State var resultError: DescopeError?
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Here is your Enchanted Link Details")
                        .font(.title)
                        .foregroundColor(Color.white)
                    
                    HStack {
                        Text("Enchanted Link ID: ")
                            .font(.headline)
                            .foregroundColor(Color.white)
                        Text(enchantedId)
                            .font(.headline)
                            .foregroundColor(Color.white)
                    }

                    HStack {
                        Button(action: {
                            Task.init {
                                try await enchantedPolling() { result, error in
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
                                    Text("Next")
                                }.padding()
                            .background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("Enchanted Link Polling Failed"),
                                        message: Text((resultError!.errorDescription!))
                                    )
                                }
                    }
                    
                    NavigationLink(destination: EnchantedLinkLoggedIn(loginId: loginId).navigationBarHidden(true).navigationBarTitle("").navigationBarBackButtonHidden(true), isActive: $isLoggedIn) { }
                    
                    
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

struct EnchantedLinkDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        EnchantedLinkDisplayView(loginId: String(), enchantedId: String())
    }
}
