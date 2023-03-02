//
//  TOTPDisplayView.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct TOTPDisplayView: View {
    @State var loginId: String
    @State var totpImage: UIImage
    @State var totpKey: String
    let verticalPaddingForForm = 20.0
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Here is your TOTP Details")
                        .font(.title)
                        .foregroundColor(Color.white)
                    

                    //UIImageView(image:  totpImage)
                    HStack {
                        Image(uiImage: totpImage).fixedSize()
                    }
                    
                    HStack {
                        Text("TOTP Key: ")
                            .font(.headline)
                            .foregroundColor(Color.white)
                        Text(totpKey)
                            .font(.headline)
                            .foregroundColor(Color.white)
                    }

                    
                    NavigationLink(destination: TOTPVerifyView(loginId:loginId).navigationBarBackButtonHidden(true)) {
                        Text("Now Verify")
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
        };
    }
}

struct TOTPDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        TOTPDisplayView(loginId: String(), totpImage: UIImage(), totpKey: String())
    }
}
