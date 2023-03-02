//
//  ContentView.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct ContentView: View {
    let verticalPaddingForForm = 20.0
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Welcome To Descope Sample App")
                        .font(.title)
                        .foregroundColor(Color.white)
                    
                    Text("Choose an authentication method to test with")
                        .font(.headline)
                        .foregroundColor(Color.white)
                    
                    VStack(spacing: CGFloat(verticalPaddingForForm)) {
                        NavigationLink(destination: SSOView().navigationBarBackButtonHidden(true)) {
                            Text("SSO")
                                .padding()
                        }.background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                        
                        NavigationLink(destination: OTPView().navigationBarBackButtonHidden(true)) {
                            Text("OTP")
                                .padding()
                        }.background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .frame(width: 200)
                        
                        NavigationLink(destination: TOTPView().navigationBarBackButtonHidden(true)) {
                            Text("TOTP")
                                .padding()
                        }.background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .frame(width: 200)
                        
                        NavigationLink(destination: MagicLinkView().navigationBarBackButtonHidden(true)) {
                            Text("Magic Link")
                                .padding()
                        }.background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .frame(width: 200)
                        
                        NavigationLink(destination: EnchantedLinkView().navigationBarBackButtonHidden(true)) {
                            Text("Enchanted Link")
                                .padding()
                        }.background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .frame(width: 200)
                        
                        NavigationLink(destination: OAuthView().navigationBarBackButtonHidden(true)) {
                            Text("Social Login (OAuth)")
                                .padding()
                        }.background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    }.padding()
                }.padding(.horizontal, CGFloat(verticalPaddingForForm))
            }
        };
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


