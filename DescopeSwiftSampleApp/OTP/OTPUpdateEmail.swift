//
//  OTPUpdateEmail.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct OTPUpdateEmail: View {
    @State var loginId: String = ""
    @State var userEmail: String = ""
    let verticalPaddingForForm = 20.0
    @State var initiated: Bool = false
    @State var showAlert: Bool = false
    @State var resultError: DescopeError?
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
                                try await otpUpdateEmail(loginId: loginId, email: userEmail) { result, error in
                                    resultError = error
                                    if result == true{
                                        initiated.toggle()
                                    }
                                    else {
                                        showAlert = true
                                    }
                                }
                                    }
                               }) {
                                    Text("OTP Update Email")
                                }.padding()
                            .background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("Failed Update Email"),
                                        message: Text((resultError!.errorDescription!))
                                    )
                                }
                    }
                    
                    NavigationLink(destination: VerifyOTPView(loginId:loginId, method: "email").navigationBarBackButtonHidden(true), isActive: $initiated) {
                    }
                    
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

struct OTPUpdateEmail_Previews: PreviewProvider {
    static var previews: some View {
        OTPUpdateEmail(loginId: String())
    }
}
