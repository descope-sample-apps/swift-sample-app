//
//  MagicLinkView.swift
//  LoginScreenDemo
//
//  Created by Descope 2023
//

import SwiftUI

struct MagicLinkView: View {
    let verticalPaddingForForm = 40.0
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
            VStack(spacing: CGFloat(verticalPaddingForForm)) {
                Text("Choose which function you would like to test with Magic Link")
                    .font(.title)
                    .foregroundColor(Color.white)

                    NavigationLink(destination: SignUpMagicLink().navigationBarBackButtonHidden(true)) {
                        Text("Sign Up")
                            .padding()
                    }.background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                    
                    NavigationLink(destination: SignInMagicLink().navigationBarBackButtonHidden(true)) {
                        Text("Sign In")
                            .padding()
                    }.background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)

                NavigationLink(destination: SignUpOrInMagicLink().navigationBarBackButtonHidden(true)) {
                    Text("Sign Up Or In")
                        .padding()
                }.background(Color.black)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                
                
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

struct MagicLinkView_Previews: PreviewProvider {
    static var previews: some View {
        MagicLinkView()
    }
}
