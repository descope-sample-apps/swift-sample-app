//
//  OTPLoggedIn.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI

struct PasswordsLoggedIn: View {
    @State  var loginId: String
    let verticalPaddingForForm = 40.0
    // @State var loggedInUserName: String
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Successfully Signed In " + loginId)
                        .font(.title)
                        .foregroundColor(Color.white)
                    
                    HStack {
//                        NavigationLink(destination: OTPUpdateEmail(loginId:loginId).navigationBarBackButtonHidden(true)) {
//                            Text("Update Email via OTP")
//                                .padding()
//                        }.background(Color.black)
//                            .foregroundColor(Color.white)
//                            .cornerRadius(10)
//
//                        NavigationLink(destination: OTPUpdatePhone(loginId:loginId).navigationBarBackButtonHidden(true)) {
//                            Text("Update Phone via OTP")
//                                .padding()
//                        }.background(Color.black)
//                        .foregroundColor(Color.white)
//                        .cornerRadius(10)
                    }

                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                        Text("Back to home screen")
                            .padding()
                    }
                    .background(Color.black)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    // Handle logout
                }.padding(.horizontal, CGFloat(verticalPaddingForForm))
            }
        };
    }
}

struct PasswordsLoggedIn_Previews: PreviewProvider {
    static var previews: some View {
        PasswordsLoggedIn(loginId: String())
    }
}
