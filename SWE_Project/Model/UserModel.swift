//
//  UserModel.swift
//  SWE_Project
//
//  Created by Khalid R on 06/03/1446 AH.
//

import Foundation

struct UserModel: Codable {
    var id = UUID() // ALready has ID
    
    
    var username : String = ""
    var email: String = ""
    var password: String = ""

    var bookmarks: [PlaceModel] = []
    var reservations: [PlaceModel] = []


}
