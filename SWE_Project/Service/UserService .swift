//
//  UserService .swift
//  Virtual Investing Project
//
//  Created by khalid doncic on 06/03/1446 AH.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class UserService: ObservableObject  {
  
    static let shared = UserService()
    @Published var user: UserModel = .init()

    
    let auth: Auth
    let firestore: Firestore
    
    

    init() {
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
    
    }


    
    func fetchUser() async throws{
        guard let userID = auth.currentUser?.uid else {throw URLError(.badURL)}
        let docRef = firestore.collection("Users").document(userID)
        
        let docSnap = try await docRef.getDocument()
     
            guard let user = try? docSnap.data(as: UserModel.self) else {
                throw URLError(.badURL)
            }
        DispatchQueue.main.async {
            self.user = user
        }
       
    }

    

    

   
}

