import SwiftUI

struct JourneyView: View {
    @StateObject var placeViewModel = PlaceViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundApp
                .ignoresSafeArea()
            VStack {
                // Plan Selection View
                PlanSelectionView(selectedPlan: $placeViewModel.selectedPlan)
                
                VStack(spacing: 0) {
                    // First Card + Horizontal Line
                    HStack {
                        JourneyCardView(place: placeViewModel.placesForPlan(plan: placeViewModel.selectedPlan)[0])
                        DashedLine()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
                            .frame(width: 100, height: 1)
                            .foregroundColor(.black)
                    }
                    .offset(y: 30)
                    
                    
                    HStack {
                        Spacer()
                        Rectangle()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
                            .frame(width: 1, height: 100)
                            .foregroundColor(.black)
                    }.padding(.horizontal)
                    
              
                    HStack {
                        Spacer()
                     Rectangle()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
                            .frame(width: 1, height: 100)
                            .foregroundColor(.black)
                    }.padding(.horizontal)
                    
                   
                    HStack {
                        JourneyCardView(place: placeViewModel.placesForPlan(plan: placeViewModel.selectedPlan)[1])
                        
                        DashedLine()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
                            .frame(width: 100, height: 1)
                            .foregroundColor(.black)
                    }
                    .offset(y: -30)
                    HStack {
                        Rectangle()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
                            .frame(width: 1, height: 100)
                            .foregroundColor(.black)
                        Spacer()
                    }.padding(.horizontal)
                        .offset(y: -30)
                    // Third Card + Horizontal Line
                    HStack {
                        Rectangle()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
                            .frame(width: 100, height: 1)
                            .foregroundColor(.black)
                        
                        JourneyCardView(place: placeViewModel.placesForPlan(plan: placeViewModel.selectedPlan)[2])
                    }
                    .offset(y: -60)
                    
                    HStack {
                        Spacer()
                     Rectangle()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5, 3]))
                            .frame(width: 1, height: 100)
                            .foregroundColor(.black)
                    }.padding(.horizontal)
                        .offset(x: -140 ,y: -60)
                }
                
              Image("Enjoy")
                    .resizable()
                    .frame(width: 285, height: 42)
                    .offset(x: 40,y: -50)
                Spacer()
            }
            .padding(10)
            .padding(.top, 40)
        }
    }
}

struct DashedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // Horizontal line
        return path
    }
}



#Preview {
    ContainerView()
        .environmentObject(PlaceViewModel())
}
