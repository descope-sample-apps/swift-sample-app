//
//  OTPLoggedIn.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct FlowSignedIn: View {
    let verticalPaddingForForm = 40.0
    let session = Descope.sessionManager.session;
    
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Successfully Signed In " + (session?.user.email ?? ""))
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

struct FlowSignedIn_Previews: PreviewProvider {
    static var previews: some View {
        FlowSignedIn()
    }
}
