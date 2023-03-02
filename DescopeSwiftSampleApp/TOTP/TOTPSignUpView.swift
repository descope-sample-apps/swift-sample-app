//
//  TOTPSignUpView.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct TOTPSignUpView: View {
    @State var loginId: String = ""
    @State var userPhone: String = ""
    @State var name: String = ""
    @State var initiated: Bool = false
    @State var showAlert: Bool = false
    @State var resultError: DescopeError?
    @State var totpResponse: TOTPResponse?
    @State var thisImage: UIImage?
    let verticalPaddingForForm = 20.0
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Sign Up In App")
                        .font(.title)
                        .foregroundColor(Color.white)
                    HStack {
                        TextField("Enter your Name", text: $name)
                            .foregroundColor(Color.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack {
                        TextField("Enter your Email", text: $loginId)
                            .foregroundColor(Color.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack {
                        TextField("Enter your Phone Number", text: $userPhone)
                            .foregroundColor(Color.black)
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack {
                        Button(action: {
                            Task.init {
                                try await totpSignUp(userEmail: loginId, loginId: loginId, userPhone: userPhone, name: name) { result, response, error in
                                    resultError = error
                                    totpResponse = response
                                    if result == true{
                                        thisImage = totpResponse!.image
                                        initiated.toggle()
                                    }
                                    else {
                                        showAlert = true
                                    }
                                }
                                    }
                               }) {
                                    Text("Sign Up TOTP")
                                }.padding()
                            .background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("TOTP Sign Up Failed"),
                                        message: Text((resultError!.errorDescription!))
                                    )
                                }
                    }
                    
                    NavigationLink(destination: TOTPDisplayView(loginId: loginId, totpImage: thisImage ?? UIImage(), totpKey:totpResponse?.key ?? "x").navigationBarHidden(true).navigationBarTitle("").navigationBarBackButtonHidden(true), isActive: $initiated) { }
                    
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

struct TOTPSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        TOTPSignUpView()
    }
}
