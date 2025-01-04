//
//  SwiftUIView.swift
//  SWE_Project
//
//  Created by Khalid R on 29/03/1446 AH.
//

import SwiftUI
struct PlanSelectionView: View {
    @Binding var selectedPlan: Int
    let totalPlans = 4

    var body: some View {
        HStack(spacing: 10) {
            ForEach(1...totalPlans, id: \.self) { plan in
                Button(action: {
                    selectedPlan = plan
                }) {
                    Text("Plan \(plan)")
                        .font(.ericaOne(size: 16))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(selectedPlan == plan ? Color.greenApp : Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(selectedPlan == plan ? .white : .gray)
                        .fixedSize()
                }
            }
        }
        .padding()
    }
}
