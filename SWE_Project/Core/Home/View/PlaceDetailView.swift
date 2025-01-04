//
//  PlaceDetailView.swift
//  SWE_Project
//
//  Created by Khalid R on 27/03/1446 AH.
//

import SwiftUI



struct PlaceDetailView: View {
    @Environment  (\.dismiss) var  dismiss
    @ObservedObject var userViewModel = UserOprtionViewModel()
    @State var existed: Bool = false
    @State var existedR: Bool = false
    @Binding var place: PlaceModel
    var body: some View {
      
        VStack(spacing: 10) {
            ZStack(alignment: .top) {
                Color.white
            
                
                if let firstImage = place.images?.first, let url = URL(string: firstImage) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .frame(width: 380, height: 400)
                            .cornerRadius(30)
                    } placeholder: {
                        
                        ProgressView()
                            .frame(width: 380, height: 400)
                    }
                }
                
                
                HStack(spacing: 20) {
                    
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 35))
                            .foregroundColor(.gray)
                            .frame(width: 50, height: 50)
                            .background(Color.white)
                            .cornerRadius(30)
                    }
                    
                    
                    Spacer()
                    
              SaveButton
                    
                    
                } .padding([.horizontal, .top])
                
                
                
            }
            .frame(width: 343, height: 390)
            .padding(.all, 20)
            .cornerRadius(40)
            
            HStack {
                VStack(alignment: .leading, spacing: 10){
                    Text(place.type?.title ?? "")
                        .font(.ericaOne(size: 16))
                    Text(place.name ?? "")
                        .font(.ericaOne(size: 12))
                        .foregroundStyle(.gray)
                }
                Spacer()
                HStack {
                    Text("\(place.rate ?? 0.0, format: .number)")
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }
            }
            .padding(.horizontal)
            
            Text(place.description ?? "")
                .font(.ericaOne(size: 14))
                .foregroundStyle(.gray)
                .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    
                    ForEach(place.images ?? [], id: \.self) { imageUrlString in
                        if let url = URL(string: imageUrlString) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 84, height: 68)
                                    .cornerRadius(16)
                            } placeholder: {
                                
                                ProgressView()
                                    .frame(width: 84, height: 68)
                            }
                        } else {
                            
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 84, height: 68)
                                .cornerRadius(16)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                }
            }

            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Price")
                    
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
                Spacer()
                Button(action: {
                    userViewModel.bookPlace(place: place)
                    existedR.toggle()
                }, label: {
                    Text(existedR ? "Booked" : "Book")
                        .foregroundStyle(.white)
                        .font(.ericaOne(size: 16))
                        .frame(width: 170)
                        .padding()
                        .background(Color.greenApp)
                        .cornerRadius(25)
                })
            }
            .padding()
            .padding(.top)
            .navigationBarBackButtonHidden()
        }
        .onAppear {
                  existed = userViewModel.user.bookmarks.contains(where: { $0.id == place.id })
                  existedR = userViewModel.user.reservations.contains(where: { $0.id == place.id })
              }
     
        
        .ignoresSafeArea()
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

//#Preview {
//    PlaceDetailView()
//}


extension PlaceDetailView {
    var SaveButton: some View {  
  
             Button {
                userViewModel.updateWatchListState(place: place, existed: existed)
                   existed.toggle()
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 60, height: 60)
                    
                    Image(existed ? "Booked" : "Book")
                    
                    
                }
                .frame(width: 70, height: 70)
            }
        
    }
    
}
