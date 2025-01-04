import SwiftUI

struct PlaceCardView: View {
    @Binding var place: PlaceModel

    var body: some View {
        ZStack {
            HStack {
                imageSection
                VStack(alignment: .leading) {
                    placeDetails
                    Spacer()
                    pricingDetails
                }
                Spacer()
            }
            .frame(width: 361, height: 112, alignment: .leading)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, 20)
        }
    }

    // Extracted image loading section
    private var imageSection: some View {
        Group {
            if let firstImage = place.images?.first, let url = URL(string: firstImage) {
                AsyncImage(url: url, content: imageContent, placeholder: imagePlaceholder)
            }
        }
    }

    private func imageContent(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 102, height: 96)
            .clipped()
    }

    private func imagePlaceholder() -> some View {
        ProgressView()
            .frame(width: 102, height: 96)
    }

    // Extracted details about the place
    private var placeDetails: some View {
        VStack(alignment: .leading, spacing: 10) {
            placeName
            visitTime
        }
    }

    private var placeName: some View {
        Text(place.name ?? "Unknown Place")
            .font(.ericaOne(size: 12))
            .foregroundColor(.black)
            .lineLimit(2)
    }

    private var visitTime: some View {
        Text(place.visitTime ?? "Always Open")
            .font(.ericaOne(size: 12))
            .foregroundColor(Color.gray.opacity(0.5))
    }

    // Extracted pricing details
    private var pricingDetails: some View {
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

    private func priceSuffix(for place: PlaceModel) -> String {
        let bookingSuffix = " /booking"
        let nightSuffix = " /night"

        switch place.type {
        case .restaurant, .museum, .entertainment:
            return bookingSuffix
        case .hotel:
            return nightSuffix
        default:
            return ""
        }
    }
}

#Preview {
    HomeView()
}
