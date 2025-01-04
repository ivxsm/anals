import SwiftUI

struct PlaceCardView: View {
    @Binding var place: PlaceModel

    var body: some View {
        ZStack {

            
            HStack {
                if let firstImage = place.images?.first, let url = URL(string: firstImage) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 102, height: 96)
                            .clipped()
                    } placeholder: {
                        // This is shown while the image is loading
                        ProgressView()
                            .frame(width: 102, height: 96)
                    }
                }

                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(place.name ?? "Unknown Place")
                            .font(.ericaOne(size: 12))
                            .foregroundColor(.black)
//                            .fixedSize()
                            .lineLimit(2)
                        

                        Text(place.visitTime ?? "Always Open")
                            .font(.ericaOne(size: 12))
                            .foregroundColor(Color.gray.opacity(0.5))
                    }
                    Spacer()

                    VStack(alignment: .leading) {
                        if let price = place.price {
                            if price > 0 {
                                Text("\(price, specifier: "%.2f")\(priceSuffix(for: place))")
                                    .foregroundStyle(Color.greenApp)
                                    .font(.ericaOne(size: 16))
                            } else {
                                Text("Free")
                                    .foregroundStyle(Color.greenApp)
                                    .font(.ericaOne(size: 16))
                            }
                        } else {
                            Text("Contact for pricing")
                                .foregroundStyle(Color.gray)
                                .font(.ericaOne(size: 14))
                        }
                    }
                }
                Spacer()
            }
            .frame(width: 361, height: 112, alignment: .leading)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, 20)
        }
    }

    private func priceSuffix(for place: PlaceModel) -> String {
        switch place.type {
        case .restaurant:
            return " /booking"
        case .hotel:
            return " /night"
        case .museum:
            return " /booking"
        case .entertainment:
            return " /booking"
         default: return ""
        }
        
    }
}

#Preview {
HomeView()
}
