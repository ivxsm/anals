//
//  TabViewModel.swift
//  Virtual Investing Project
//
//  Created by Khalid R on 01/08/1445 AH.
//

import Foundation

enum TabViewModel: String, CaseIterable {
    case home
    case saved
    case map
    case settings
    
    var image: String {
        switch self {
        case .home:
            return "Home"
        case .saved:
            return "J"
        case .map:
           return  "Map"
        case .settings:
            return "Gear"
        }
    }
    var tabedImages: String {
        switch self {
        case .home:
            return "HomeT"
        case .saved:
            return "JT"
        case .map:
           return  "MapT"
        case .settings:
            return "GearT"
        }
    }
}
