////
////  AuthManager.swift
////  Numerology
////
////  Created by Serj_M1Pro on 28.06.2025.
////
//
//import Foundation
//import FirebaseAuth
//import AuthenticationServices
//import CryptoKit
//
//
//class AuthManager {
//    func appleAuth(
//        _ appleIDCredential: ASAuthorizationAppleIDCredential,
//        nonce: String?
//    ) async throws -> AuthDataResult? {
//        guard let nonce = nonce else {
//            fatalError("Invalid state: A login callback was received, but no login request was sent.")
//        }
//
//        guard let appleIDToken = appleIDCredential.identityToken else {
//            print("Unable to fetch identity token")
//            return nil
//        }
//
//        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
//            return nil
//        }
//
//        // 2.
//        let credentials = OAuthProvider.appleCredential(withIDToken: idTokenString,
//                                                       rawNonce: nonce,
//                                                       fullName: appleIDCredential.fullName)
//
//        do { // 3.
//            // return try await authenticateUser(credentials: credentials)
//            return try await authenticateUser(credentials: credentials)
//        }
//        catch {
//            print("FirebaseAuthError: appleAuth(appleIDCredential:nonce:) failed. \(error)")
//            throw error
//        }
//    }
//    
//    private func authenticateUser(credentials: AuthCredential) async throws -> AuthDataResult? {
//           // If we have authenticated user, then link with given credentials.
//           // Otherwise, sign in using given credentials.
//           if Auth.auth().currentUser != nil {
//               return try await authLink(credentials: credentials)
//           } else {
//               return try await authSignIn(credentials: credentials)
//           }
//       }
//    
//    private func authLink(credentials: AuthCredential) async throws -> AuthDataResult? {
//           do {
//               guard let user = Auth.auth().currentUser else { return nil }
//               let result = try await user.link(with: credentials)
//
//               await updateDisplayName(for: result.user)
//               updateState(user: result.user)
//
//               return result
//           }
//           catch {
//               print("FirebaseAuthError: link(with:) failed, \(error)")
//               if let error = error as NSError? {
//                   if let code = AuthErrorCode.Code(rawValue: error.code),
//                       authLinkErrors.contains(code) {
//
//                       // If provider is "apple.com", get updated AppleID credentials from the error object.
//                       let appleCredentials =
//                           credentials.provider == "apple.com"
//                           ? error.userInfo[AuthErrorUserInfoUpdatedCredentialKey] as? AuthCredential
//                           : nil
//
//                       return try await self.authSignIn(credentials: appleCredentials ?? credentials)
//                   }
//               }
//               throw error
//           }
//       }
//}
//
//
//// 1.
//class AppleSignInManager {
//    
//    static let shared = AppleSignInManager()
//
//    fileprivate static var currentNonce: String?
//
//    static var nonce: String? {
//        currentNonce ?? nil
//    }
//
//    private init() {}
//
//    // TODO: Запросить авторизацию Apple.
//}
//
//extension AppleSignInManager {
//    // 2.
//    private func randomNonceString(length: Int = 32) -> String {
//        precondition(length > 0)
//        var randomBytes = [UInt8](repeating: 0, count: length)
//        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
//        if errorCode != errSecSuccess {
//            fatalError(
//                "Не удалось сгенерировать nonce. SecRandomCopyBytes не удалось с OSStatus \(errorCode)"
//            )
//        }
//
//        let charset: [Character] =
//        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
//
//        let nonce = randomBytes.map { byte in
//            // Выбрать случайный символ из набор, при необходимости обертываясь.
//            charset[Int(byte) % charset.count]
//        }
//
//        return String(nonce)
//    }
//
//    // 3.
//    private func sha256(_ input: String) -> String {
//        let inputData = Data(input.utf8)
//        let hashedData = SHA256.hash(data: inputData)
//        let hashString = hashedData.compactMap {
//            return String(format: "%02x", $0)
//        }.joined()
//
//        return hashString
//    }
//}
