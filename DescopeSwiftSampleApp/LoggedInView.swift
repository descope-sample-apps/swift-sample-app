//
//  LoggedInView.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI

struct LoggedInView: View {
    @State  var loginId: String
    let verticalPaddingForForm = 20.0
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Successfully Signed In " + loginId)
                        .font(.title)
                        .foregroundColor(Color.white)

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

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView(loginId: String())
        // LoggedInView(loggedInUserName: String)
    }
}
