//
//  SavePlacesView.swift
//  SWE_Project
//
//  Created by Khalid R on 30/03/1446 AH.
//

import SwiftUI

struct SavePlacesView: View {
    @StateObject var vm = UserOprtionViewModel()
    @State var isFromSaved: Bool = true
    var body: some View {
        VStack {
            Text(isFromSaved ? "Bookmarks" : "Reservations")
                .font(.ericaOne(size: 32))
            
            Spacer().frame(height: 20)
            ScrollView {
                
                
                if isFromSaved {
                    ForEach($vm.savedPlaces) { $place in
                        PlaceCardView(place: $place)
                            .padding()
                    }
                } else {
                    ForEach($vm.resrvations) { $place in
                        PlaceCardView(place: $place)
                            .padding()
                    }
                }
            }
            
            Spacer()
            
            
        }
        
    }
}

#Preview {
    SavePlacesView()
}
