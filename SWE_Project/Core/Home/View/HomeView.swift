//
//  HomeView.swift
//  SWE_Project
//
//  Created by Khalid R on 19/03/1446 AH.
//

import SwiftUI

struct HomeView: View {
    @StateObject var weatherViewModel = WeatherViewModel()

    @EnvironmentObject var placeViewModel : PlaceViewModel
    @State private var showDropDown = false
//    @State var selectedPlace: PlaceModel

    @StateObject var placeViewModel = PlaceViewModel()
    @State private var showDropDown = false
    



    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundApp
                    .ignoresSafeArea()
                
                VStack{
                    HStack {
                        
                        
                        Text("\(String(format: "%.1f", weatherViewModel.getTemperature(for: placeViewModel.selectedCity)))°C")
                            .font(.ericaOne(size: 20))
                            .foregroundColor(.primary)
                        Spacer()
                        Image(weatherViewModel.getDayOrNightImage())
                            .resizable()
                            .frame(width: 30, height: 30)
                        Spacer()
                        citySelectionButton
                            .onChange(of: placeViewModel.selectedCity) { newCity in
                                placeViewModel.selectedCity = newCity  // Trigger ViewModel update
                            }
                        
                    }
                    .padding(.horizontal, 20)
                    
                    TextField("Search address, city, location", text: $placeViewModel.searchText)
                        .padding(.leading, 40)
                        .frame(width: 294, height: 42)
                        .padding(10)
                        .background(Color(.systemGray6))
                    
                        .cornerRadius(40)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color.greenApp)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 15)
                            }
                            
                        )
                    
                    CategoryView
                        .onChange(of: placeViewModel.selectedCategory) { newCategory in
                            placeViewModel.selectedCategory = newCategory  // Trigger ViewModel update
                        }
                    
                    
                        VStack(alignment: .leading){
                            ScrollView(.vertical, showsIndicators: false) {
                                LazyVStack(alignment: .leading) {
                                    ForEach($placeViewModel.places) { $place in
                                        NavigationLink {
                PlaceDetailView(place: $place)

                                        } label: {
                                            
                                            
                                            
                                            PlaceCardView(place: $place)
                                            
                                        }
                                    }
                                    
                                } 
                             
                                
                                
                                
                             
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top)
                        
                           
                        }
                    
                  
                
                    
                    
                    Spacer()
                    
                }
                
                .padding(.top, 110)
                .ignoresSafeArea()
                
                    if showDropDown {
                        dropDownView
                            .zIndex(1)
                    }
                    
              
            }
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    Text("TourKsa")
                        .font(.ericaOne(size: 28))
                        .foregroundStyle(Color.greenApp)
                }
            })
            
            .onChange(of: placeViewModel.selectedCity) { newCity in
                weatherViewModel.fetchWeather(for: newCity)
            }
            .onAppear {
                weatherViewModel.fetchWeather(for: placeViewModel.selectedCity)
            }
            .navigationBarBackButtonHidden()
            
        }
    }
}
#Preview {
    ContainerView()

        .environmentObject(PlaceViewModel())

}

extension HomeView {
    private var citySelectionButton: some View  {
        Button {
           
            withAnimation(.smooth) {
                showDropDown.toggle()
            }
        } label: {
            HStack {
                Text(placeViewModel.selectedCity.title)
                    .font(.ericaOne(size: 15))
                    .foregroundColor(.white)
                Image("Down_Arrow")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .rotationEffect(.degrees(showDropDown ? 180 : 0))
            }
            .padding()
            .background(Color.greenApp)
            .cornerRadius(15)
        }
        
    }
    private var dropDownView: some View  {
        VStack {
            
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    ForEach(City.allCases, id: \.self) { city in
                        Button {
                            // Set the selected market and close the dropdown
                            withAnimation {
                                placeViewModel.selectedCity = city
                                showDropDown = false
                            }
                        } label: {
                            HStack {
                                Text(city.title)
                                    .font(.ericaOne(size: 14))
                                    .foregroundColor(.white)
                                Spacer()
                                if city == placeViewModel.selectedCity {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.primary)
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                        }
                    }
                }
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(width: 150)
                .padding(.trailing, 10)
                .offset(y: -40) // Adjust dropdown position
            }
            .transition(.move(edge: .top))
            Spacer().frame(height: 450)
            
        }
    }
    
}




extension HomeView {
    var CategoryView : some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Category.allCases, id: \.self) { category in
                    Text(category.displayName)
                        .font(Font.custom("EricaOne-Regular", size: 18))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(self.placeViewModel.selectedCategory == category ? Color.greenApp : Color.clear)
                        .cornerRadius(10)
                        .foregroundColor(self.placeViewModel.selectedCategory == category ? .white : .black)
                        .onTapGesture {
                            withAnimation(.spring) {
                                self.placeViewModel.selectedCategory = category
                            }
                            
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}

