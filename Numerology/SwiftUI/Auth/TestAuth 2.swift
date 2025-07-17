//
//  LoginView.swift
//  AuthLogin
//
//  Created by Marwa Abou Niaaj on 29/11/2023.
//

import AuthenticationServices
//import GoogleSignInSwift
import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss

//    @EnvironmentObject var authManager: AuthManager
    @StateObject var authManager: AuthManager = AuthManager()

    var body: some View {
//        NavigationStack {
            VStack(spacing: 16) {
                VStack {
                    Text("\(self.authManager.user?.uid ?? "Empty" )")
                    Text("\(self.authManager.authState)")
                }
                .foregroundStyle(.black)
                
                Spacer()

                // MARK: - Apple
                SignInWithAppleButton(
                    onRequest: { request in
                        AppleSignInManager.shared.requestAppleAuthorization(request)
                    },
                    onCompletion: { result in
                        self.authManager.handleAppleID(result)
                    }
                )
                .signInWithAppleButtonStyle(colorScheme == .light ? .black : .white)
                .frame(width: 280, height: 45, alignment: .center)

                // MARK: - Google
//                GoogleSignInButton {
//                    Task {
//                        await signInWithGoogle()
//                    }
//                }
//                .frame(width: 280, height: 45, alignment: .center)

                // MARK: - Anonymous
                // Hide `Skip` button if user is anonymous.
//                if authManager.authState == .signedOut {
//                    Button {
//                        signAnonymously()
//                    } label: {
//                        Text("Skip")
//                            .font(.body.bold())
//                            .frame(width: 280, height: 45, alignment: .center)
//                    }
//                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.yellow))
//        }
    }

    /// Sign in with `Google`, and authenticate with `Firebase`.
//    func signInWithGoogle() async {
//        do {
//            guard let user = try await GoogleSignInManager.shared.signInWithGoogle() else { return }
//
//            let result = try await authManager.googleAuth(user)
//            if let result = result {
//                print("GoogleSignInSuccess: \(result.user.uid)")
//                dismiss()
//            }
//        }
//        catch {
//            print("GoogleSignInError: failed to sign in with Google, \(error))")
//            // Here you can show error message to user.
//            return
//        }
//    }


    /// Sign-in anonymously
//    func signAnonymously() {
//        Task {
//            do {
//                let result = try await authManager.signInAnonymously()
//                print("SignInAnonymouslySuccess: \(result?.user.uid ?? "N/A")")
//            }
//            catch {
//                print("SignInAnonymouslyError: \(error)")
//            }
//        }
//    }
}

#Preview {
    LoginView()
        .environmentObject(AuthManager())
}
