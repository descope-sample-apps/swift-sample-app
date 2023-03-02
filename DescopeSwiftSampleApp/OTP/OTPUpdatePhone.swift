//
//  OTPUpdatePhone.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import SwiftUI
import DescopeKit

struct OTPUpdatePhone: View {
    @State var loginId: String = ""
    @State var userPhone: String = ""
    let verticalPaddingForForm = 20.0
    @State var initiated: Bool = false
    @State var showAlert: Bool = false
    @State var resultError: DescopeError?
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470)
                VStack(spacing: CGFloat(verticalPaddingForForm)) {
                    Text("Update Phone via OTP")
                        .font(.title)
                        .foregroundColor(Color.white)
                    HStack {
                        TextField("Enter your phone number", text: $userPhone)
                            .foregroundColor(Color.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack {
                        Button(action: {
                            Task.init {
                                try await otpUpdatePhone(loginId: loginId, phone: userPhone, method: "sms") { result, error in
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
                                    Text("OTP Update Phone")
                                }.padding()
                            .background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("Failed Update Phone"),
                                        message: Text((resultError!.errorDescription!))
                                    )
                                }
                    }
                    
                    NavigationLink(destination: VerifyOTPView(loginId:loginId, method: "sms").navigationBarBackButtonHidden(true), isActive: $initiated) {
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

struct OTPUpdatePhone_Previews: PreviewProvider {
    static var previews: some View {
        OTPUpdatePhone(loginId: String())
    }
}
