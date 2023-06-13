//
//  Handlers.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import Foundation
import DescopeKit
import AuthenticationServices
import SwiftUI

var descopeSession: DescopeSession?
var enchantedResponse: EnchantedLinkResponse?

// OTP
func otpSignUp (userEmail: String, loginId: String, userPhone: String, name: String, method: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    let myUser = User(name: name, phone: userPhone, email: userEmail)
    Task {
        do {
            print(myUser)
            print("Login ID: " + loginId)
            if method == "email" {
                try await Descope.otp.signUp(with: DeliveryMethod.email, loginId: loginId, details: myUser)
            } else if method == "sms" {
                try await Descope.otp.signUp(with: DeliveryMethod.sms, loginId: loginId, details: myUser)
            }
            print("Successfully initiated OTP Sign Up")
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

func otpSignUpOrIn (loginId: String, method: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    Task {
        do {
            if method == "email" {
                try await Descope.otp.signUpOrIn(with: .email, loginId: loginId)
            } else if method == "sms" {
                try await Descope.otp.signUpOrIn(with: .sms, loginId: loginId)
            }
            print("Successfully initiated OTP Sign Up or In")
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            //let descopeError = DescopeError(error as Any)
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

func otpSignIn (loginId: String, method: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    Task {
        do {
            if method == "email" {
                try await Descope.otp.signIn(with: .email, loginId: loginId)
            } else if method == "sms" {
                try await Descope.otp.signIn(with: .sms, loginId: loginId)
            }
            print("Successfully initiated OTP Sign In")
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

func otpVerify (verifyCode: String, loginId: String, method: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    Task {
        do {
            if method == "email" {
                
                let authResponse = try await Descope.otp.verify(with: .email, loginId: loginId, code: verifyCode)
                descopeSession = DescopeSession(from: authResponse)
                print(descopeSession as Any)
            } else if method == "sms" {
                let authResponse = try await Descope.otp.verify(with: .sms, loginId: loginId, code: verifyCode)
                descopeSession = DescopeSession(from: authResponse)
                print(descopeSession as Any)
            }
            print("Successfully verified OTP Code")
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

func otpUpdateEmail (loginId: String, email: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    Task {
        do {
            try await Descope.otp.updateEmail(email, loginId: loginId, refreshJwt: descopeSession!.refreshJwt, options: UpdateOptions(rawValue: 1))
            print("Successfully started OTP Email Update")
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

func otpUpdatePhone (loginId: String, phone: String, method: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    Task {
        do {
            if method == "sms" {
                try await Descope.otp.updatePhone(phone, with: .sms, loginId: loginId, refreshJwt: descopeSession!.refreshJwt, options: UpdateOptions(rawValue: 1))
                print("Successfully started OTP Phone Update")
            }
            // Later add whatsapp
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

// TOTP
func totpSignUp (userEmail: String, loginId: String, userPhone: String, name: String, completionHandler: @escaping (Bool, TOTPResponse?, DescopeError?) -> Void) async throws {
    let myUser = User(name: name, phone: userPhone, email: userEmail)
    Task {
        do {
            let totpResponse = try await Descope.totp.signUp(loginId: loginId.lowercased(), details: myUser)
            print("Successfully initiated TOTP SignUp")
            print("TOTP QR Code: Returned as a UIImage within totpResponse.image")
            print("TOTP Key: " + totpResponse.key)
            print("TOTP Provisioning URL: " + totpResponse.provisioningURL)
            print(totpResponse)
            completionHandler(true, totpResponse, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, nil, descopeErr)
        }
    }
}

func totpUpdate (loginId: String, completionHandler: @escaping (Bool, TOTPResponse?, DescopeError?) -> Void) async throws {
    Task {
        do {
            let totpResponse = try await Descope.totp.update(loginId: loginId.lowercased(), refreshJwt: descopeSession!.refreshJwt)
            print("Successfully initiated TOTP Update")
            print(totpResponse)
            completionHandler(true, totpResponse, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, nil, descopeErr)
        }
    }
}

func totpVerify (verifyCode: String, loginId: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    Task {
        do {
            print("TOTP Code: " + verifyCode)
            print("Login ID: " + loginId)
            let authResponse = try await Descope.totp.verify(loginId: loginId.lowercased(), code: verifyCode)
            descopeSession = DescopeSession(from: authResponse)
            print("Successfully verified TOTP Code")
            print(descopeSession as Any)
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

// Enchanted Link
func enchantedSignUp (userEmail: String, loginId: String, userPhone: String, name: String, completionHandler: @escaping (Bool, EnchantedLinkResponse?, DescopeError?) -> Void) async throws {
    //let myUser = DescopeKit.User(name: "Desmond Copeland")
    let myUser = User(name: name, phone: userPhone, email: userEmail)
    print("I am here")
    // DescopeKit.User(name: "Desmond Copeland")
    Task {
        do {
            enchantedResponse = try await Descope.enchantedLink.signUp(loginId: loginId, details: myUser, uri: "https://meauthy.co")
            print("Successfully initiated Enchanted SignUp")
            print("Enchanted Link linkId: " + enchantedResponse!.linkId)
            print("Enchanted Link pendingRef: " + enchantedResponse!.pendingRef)
            completionHandler(true, enchantedResponse, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, nil, descopeErr)
        }
    }
}

func enchantedPolling (completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    Task {
        do {
            let authResponse = try await Descope.enchantedLink.pollForSession(pendingRef: enchantedResponse!.pendingRef, timeout: 180)
            descopeSession = DescopeSession(from: authResponse)
            print("Successfully found session")
            print(descopeSession as Any)
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
    
}

func enchantedLinkUpdateEmail (loginId: String, email: String, completionHandler: @escaping (Bool, EnchantedLinkResponse?, DescopeError?) -> Void) async throws {
    Task {
        do {
            enchantedResponse = try await Descope.enchantedLink.updateEmail(email, loginId: loginId, uri: "https://meauthy.co", refreshJwt: descopeSession!.refreshJwt, options: UpdateOptions(rawValue: 1))
            print("Successfully started Enchanted Link Email Update")
            print(enchantedResponse as Any)
            completionHandler(true, enchantedResponse, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, nil, descopeErr)
        }
    }
}

func enchantedLinkSignUpOrIn (loginId: String, completionHandler: @escaping (Bool, EnchantedLinkResponse?, DescopeError?) -> Void) async throws {
    
    Task {
        do {
            enchantedResponse = try await Descope.enchantedLink.signUpOrIn(loginId: loginId, uri: "https://meauthy.co")
            print("Successfully initiated Enchanted Link Sign Up Or In")
            print(enchantedResponse as Any)
            completionHandler(true, enchantedResponse, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, nil, descopeErr)
        }
    }
}

func enchantedLinkSignIn (loginId: String, completionHandler: @escaping (Bool, EnchantedLinkResponse?, DescopeError?) -> Void) async throws {
    // DescopeKit.User(name: "Desmond Copeland")
    Task {
        do {
            enchantedResponse = try await Descope.enchantedLink.signIn(loginId: loginId, uri: "https://meauthy.co")
            print("Successfully initiated Enchanted Link SignIn")
            print(enchantedResponse as Any)
            completionHandler(true, enchantedResponse, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, nil, descopeErr)
        }
    }
}

// MagicLink
func magicLinkSignUp (userEmail: String, loginId: String, userPhone: String, name: String, method: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    //let myUser = DescopeKit.User(name: "Desmond Copeland")
    let myUser = User(name: name, phone: userPhone, email: userEmail)
    // DescopeKit.User(name: "Desmond Copeland")
    Task {
        do {
            print(myUser)
            print("Login ID: " + loginId)
            if method == "email" {
                try await Descope.magicLink.signUp(with: .email, loginId: loginId, details: myUser, uri: "https://meauthy.co")
            } else if method == "sms" {
                try await Descope.magicLink.signUp(with: .sms, loginId: loginId, details: myUser, uri: "https://meauthy.co")
            }
            print("Successfully initiated Magic Link SignUp")
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

func magicLinkSignUpOrIn (loginId: String, method: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    
    Task {
        do {
            if method == "email" {
                try await Descope.magicLink.signUpOrIn(with: .email, loginId: loginId, uri: "https://meauthy.co")
            } else if method == "sms" {
                try await Descope.magicLink.signUpOrIn(with: .sms, loginId: loginId, uri: "https://meauthy.co")
            }
            print("Successfully initiated Magic Link SignUp")
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

func magicLinkSignIn (loginId: String, method: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    
    
    // DescopeKit.User(name: "Desmond Copeland")
    Task {
        do {
            if method == "email" {
                try await Descope.magicLink.signIn(with: .email, loginId: loginId, uri: "https://meauthy.co")
            } else if method == "sms" {
                try await Descope.magicLink.signIn(with: .sms, loginId: loginId, uri: "https://meauthy.co")
            }
            print("Successfully initiated Magic Link Sign In")
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

func magicLinkVerify (token: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    // DescopeKit.User(name: "Desmond Copeland")
    Task {
        do {
            let authResponse = try await Descope.magicLink.verify(token: token)
            descopeSession = DescopeSession(from: authResponse)
            print("Successfully verified Magic Link Token")
            print(descopeSession as Any)
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

func magicLinkUpdateEmail (loginId: String, email: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    Task {
        do {
            try await Descope.magicLink.updateEmail(email, loginId: loginId, uri: "https://meauthy.co", refreshJwt: descopeSession!.refreshJwt, options: UpdateOptions(rawValue: 1))
            print("Successfully started Magic Link Email Update")
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

func magicLinkUpdatePhone (loginId: String, phone: String, method: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    Task {
        do {
            if method == "sms" {
                try await Descope.magicLink.updatePhone(phone, with: .sms, loginId: loginId, uri: "https://meauthy.co", refreshJwt: descopeSession!.refreshJwt, options: UpdateOptions(rawValue: 1))
                print("Successfully started Magic Link Email Update")
                completionHandler(true, nil)
            }
            // Later add whatsapp
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

// OAuth
class OAuthLoginSession: NSObject,
    ObservableObject,
                    ASWebAuthenticationPresentationContextProviding {
    var webAuthSession: ASWebAuthenticationSession?
    
    func presentationAnchor(for session: ASWebAuthenticationSession)
    -> ASPresentationAnchor {
      let window = UIApplication.shared.windows.first { $0.isKeyWindow }
      return window ?? ASPresentationAnchor()
    }
    
    func OAuthLogin (provider: OAuthProvider, context: ASWebAuthenticationPresentationContextProviding, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
        // Choose which tenant to log into
        // If configured globally, the return URL is optional. If provided however, it will be used
        // instead of any global configuration.
        // Redirect the user to the returned URL to start the SSO/SAML redirect chain
            do {
                let authURL = try await Descope.oauth.start(provider: provider, redirectURL: "exampleauthschema://my-app.com/handle-oauth")
                guard let authURL = URL(string: authURL) else { return }
                // Start the authentication session
                let session = ASWebAuthenticationSession(
                    url: authURL,
                    callbackURLScheme: "exampleauthschema") { callbackURL, error in
                    
                    guard let url = callbackURL else {return}
                    let component = URLComponents(url: url, resolvingAgainstBaseURL: false)
                    guard let code = component?.queryItems?.first(where: {$0.name == "code"})?.value else { return }
                    print(code)
                    
                        // ... Trigger asynchronously
                    // Exchange code for session
                    Task {
                        do {
                            let authResponse = try await Descope.oauth.exchange(code: code)
                            descopeSession = DescopeSession(from: authResponse)
                            completionHandler(true, nil)
                        } catch let descopeErr as DescopeError {
                            print(descopeErr)
                            completionHandler(false, descopeErr)
                        }
                        print(descopeSession as Any)
                    }
                }
                session.presentationContextProvider = self
                session.prefersEphemeralWebBrowserSession = true
                session.start()
            } catch {
                print(error)
                completionHandler(false, nil)
            }
        }
}

// SSO
class SSOLoginSession: NSObject,
    ObservableObject,
                    ASWebAuthenticationPresentationContextProviding {
    var webAuthSession: ASWebAuthenticationSession?
    
    func presentationAnchor(for session: ASWebAuthenticationSession)
    -> ASPresentationAnchor {
      let window = UIApplication.shared.windows.first { $0.isKeyWindow }
      return window ?? ASPresentationAnchor()
    }
    
    func SSOLogin (email: String, context: ASWebAuthenticationPresentationContextProviding, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
        // Choose an oauth provider out of the supported providers
        // If configured globally, the redirect URL is optional. If provided however, it will be used
        // instead of any global configuration.
        // Redirect the user to the returned URL to start the OAuth redirect chain
        do {
            let authURL = try await Descope.sso.start(emailOrTenantName: email, redirectURL: "exampleauthschema://my-app.com/handle-saml")
            guard let authURL = URL(string: authURL) else { return }
            // Start the authentication session
            let session = ASWebAuthenticationSession(
                url: authURL,
                callbackURLScheme: "exampleauthschema") { callbackURL, error in
                    
                    guard let url = callbackURL else {return}
                    let component = URLComponents(url: url, resolvingAgainstBaseURL: false)
                    guard let code = component?.queryItems?.first(where: {$0.name == "code"})?.value else { return }
                    print(code)
                    
                    Task.init {
                        do {
                            let authResponse = try await Descope.sso.exchange(code: code)
                            descopeSession = DescopeSession(from: authResponse)

                            completionHandler(true, nil)
                        } catch let descopeErr as DescopeError {
                            print(descopeErr)
                            completionHandler(false, descopeErr)
                        }
                        print(descopeSession as Any)
                    }
                }
            session.presentationContextProvider = self
            session.prefersEphemeralWebBrowserSession = true
            session.start()
        } catch {
            print(error)
            completionHandler(false, nil)
        }
    }
}



// Passwords
func passwordsSignUp (userPassword: String, userEmail: String, loginId: String, userPhone: String, name: String, method: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    let myUser = User(name: name, phone: userPhone, email: userEmail)
    Task {
        do {
            print(myUser)
            print("Login ID: " + loginId)
            if method == "email" {
//                try await Descope.password.signUp(with: DeliveryMethod.email, loginId: loginId, user: myUser)
            } else if method == "sms" {
                try await Descope.otp.signUp(with: DeliveryMethod.sms, loginId: loginId, details: myUser)
            }
            print("Successfully initiated OTP Sign Up")
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

func passwordsSignUpOrIn (userPassword: String, loginId: String, method: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    Task {
        do {
            if method == "email" {
                try await Descope.otp.signUpOrIn(with: .email, loginId: loginId)
            } else if method == "sms" {
                try await Descope.otp.signUpOrIn(with: .sms, loginId: loginId)
            }
            print("Successfully initiated OTP Sign Up or In")
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            //let descopeError = DescopeError(error as Any)
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

func passwordsSignIn (userPassword: String, loginId: String, method: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    Task {
        do {
            if method == "email" {
                try await Descope.otp.signIn(with: .email, loginId: loginId)
            } else if method == "sms" {
                try await Descope.otp.signIn(with: .sms, loginId: loginId)
            }
            print("Successfully initiated OTP Sign In")
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

func passwordsVerify (verifyCode: String, loginId: String, method: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    Task {
        do {
            if method == "email" {
                let authResponse = try await Descope.otp.verify(with: .email, loginId: loginId, code: verifyCode)
                descopeSession = DescopeSession(from: authResponse)
                print(descopeSession as Any)
            } else if method == "sms" {
                let authResponse = try await Descope.otp.verify(with: .sms, loginId: loginId, code: verifyCode)
                descopeSession = DescopeSession(from: authResponse)
                print(descopeSession as Any)
            }
            print("Successfully verified OTP Code")
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

func passwordsUpdateEmail (loginId: String, email: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    Task {
        do {
            try await Descope.otp.updateEmail(email, loginId: loginId, refreshJwt: descopeSession!.refreshJwt, options: UpdateOptions(rawValue: 1))
            print("Successfully started OTP Email Update")
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}

func passwordsUpdatePhone (loginId: String, phone: String, method: String, completionHandler: @escaping (Bool, DescopeError?) -> Void) async throws {
    Task {
        do {
            if method == "sms" {
                try await Descope.otp.updatePhone(phone, with: .sms, loginId: loginId, refreshJwt: descopeSession!.refreshJwt, options: UpdateOptions(rawValue: 1))
                print("Successfully started OTP Phone Update")
            }
            // Later add whatsapp
            completionHandler(true, nil)
        } catch let descopeErr as DescopeError {
            print(descopeErr)
            completionHandler(false, descopeErr)
        }
    }
}
