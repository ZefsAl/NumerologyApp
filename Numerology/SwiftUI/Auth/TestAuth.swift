//
//  TestAuth.swift
//  Numerology
//
//  Created by Serj_M1Pro on 23.06.2025.
//

import SwiftUI


import AuthenticationServices
//import FirebaseAuth
//import RevenueCat


struct TestAuth: View {
    
    @State var text = ""
    
    var body: some View {
        VStack {
            SignInWithAppleButton(.signUp) { request in
                // authorization request for an Apple ID
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                // completion handler that is called when the sign-in completes
                switch result {
                case .success(let authorization):
                    handleSuccessfulLogin(with: authorization)
                    if let userCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                        print("", userCredential)
                    
                        if userCredential.authorizedScopes.contains(.fullName) {
                            print(userCredential.fullName)
                        }
                    
                        if userCredential.authorizedScopes.contains(.email) {
                            print(userCredential.email)
                        }
                    }
                case .failure(let error):
                    handleLoginError(with: error)
                    print("Could not authenticate: \\(error.localizedDescription)")
                }
            }
            .frame(width: 300, height: 50, alignment: .center)
            .clipShape(.capsule)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(.white)
    }
    
    private func handleSuccessfulLogin(with authorization: ASAuthorization) {
            if let userCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                print(userCredential.user)
                
                if userCredential.authorizedScopes.contains(.fullName) {
                    print(userCredential.fullName?.givenName ?? "No given name")
                }
                
                if userCredential.authorizedScopes.contains(.email) {
                    print(userCredential.email ?? "No email")
                }
            }
        }
        
        private func handleLoginError(with error: Error) {
            print("Could not authenticate: \\(error.localizedDescription)")
        }
}

#Preview {
    TestAuth()
}


// 1  -  001454.43f4fb4b639946f688b295765814e3bc.1213
