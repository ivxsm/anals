//
//  ProfileView.swift
//  SWE_Project
//
//  Created by Khalid R on 30/03/1446 AH.
//

import SwiftUI



struct ProfileView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
               
                Text("Profile")
                    .font(.ericaOne(size: 32))
                
                Spacer().frame(height: 20)
                
                // Profile Image and Info
                VStack() {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                    
                    Text(UserService.shared.user.username)
                        .font(.ericaOne(size: 20))
                        .foregroundColor(.black)
                    
                    Text(UserService.shared.auth.currentUser?.email ?? "khalidaldz@gmail.com")
                        .font(.ericaOne(size: 16))
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 40)
                
                
                VStack(alignment: .leading,spacing: 55) {
                    NavigationLink {
                        SavePlacesView(isFromSaved: false)
                    }label: {
                        
                        
                        ProfileMenuItem(iconName: "MR", title: "Manage Reservation")
                    }
                    NavigationLink {
                        SavePlacesView(isFromSaved: true)
                    }label: {
                        
                        
                        ProfileMenuItem(iconName: "Book", title: "Saved Places")
                    }
                  
                }
                .padding(.trailing, 20)
                
                Spacer()
                
                // Log Out Button
                Button(action: {
                    // Log Out action
                }) {
                    Text("Log Out")
                        .font(.ericaOne(size: 20))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                        .background(Color.greenApp)
                        .cornerRadius(25)
                }
                .padding(.bottom, 40)
            }
            .background(Color.white.ignoresSafeArea())
        }
    }
}

// Helper view for profile menu items
struct ProfileMenuItem: View {
    var iconName: String
    var title: String

    var body: some View {
        HStack {
            Image(iconName)
                .resizable()
                .frame(width: 30, height: 30)
                .padding()
                .background(Color(.systemGray6))
                .clipShape(Circle())
            
            Text(title)
                .font(.ericaOne(size: 20))
                .foregroundColor(.black)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ProfileView()
}
