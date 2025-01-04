//
//  AuthError.swift
//  Virtual Investing Project
//
//  Created by Khalid R on 06/03/1446 AH.
//

import Foundation
 


enum AuthError:LocalizedError {
    case customError(message: String)
    case invalidInput
//    case emailNotVerified
    
      
    var errorDescription: String?  {
        switch self {
        case .invalidInput:
            return "Invalid input. Please make sure all fields are filled out correctly."
//        case .emailNotVerified:
//            return "Your email address has not been verified. Please check your inbox."
        case .customError(let message):
            return message
        }
    }
}






