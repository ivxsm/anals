//
//  JourneyCardView.swift
//  SWE_Project
//
//  Created by Khalid R on 29/03/1446 AH.
//

import SwiftUI

struct JourneyCardView: View {
    var place: PlaceModel

    var body: some View {
        HStack {
            if let firstImage = place.images?.first, let url = URL(string: firstImage) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                        .padding(.leading)
                } placeholder: {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
            }
            
            VStack(alignment: .leading) {
                Text(place.name ?? "Unknown Place")
                    .font(.headline)
                    .foregroundColor(.black)
                Text(place.visitTime ?? "Open all day")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .frame(width: 249, height: 73) // Fixed size
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}
