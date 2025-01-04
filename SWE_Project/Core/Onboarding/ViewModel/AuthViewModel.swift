//
//  AuthViewModel.swift
//  Virtual Investing Project
//
//  Created by Khalid R on 06/03/1446 AH.
//
import Foundation

class AuthViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @MainActor
    func createUser() async throws {
        if email.isEmpty || password.isEmpty  {
            throw AuthError.invalidInput
        }
        do {
            let authResult = try await UserService.shared.auth.createUser(withEmail: email, password: password)
            let user = authResult.user
//            do {
//                try await user.sendEmailVerification()
//                
//            } catch  {
//                throw AuthError.customError(message: "Failed to send verification email.")
//            }
            
            let newUser = UserModel(username: userName, email: email, password: password)
            try UserService.shared.firestore.collection("Users").document(user.uid).setData(from: newUser)
        } catch  {
            throw AuthError.customError(message: "Failed to create user account. \(error.localizedDescription)")
        }
    }
    
    @MainActor
        func logIn() async throws {
        if email.isEmpty || password.isEmpty {
           throw AuthError.invalidInput
        }
        do {
            let authResult = try await UserService.shared.auth.signIn(withEmail: email, password: password)
            let user = authResult.user
//            guard user.isEmailVerified else {
//                throw AuthError.emailNotVerified
//            }
        } catch {
            throw AuthError.customError(message: error.localizedDescription)
        }
        
    }

}
