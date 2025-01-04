//
//  SignInView.swift
//  SWE_Project
//
//  Created by Khalid R on 06/03/1446 AH.
//

import SwiftUI

struct SignInView: View {
    @StateObject var vm: AuthViewModel = AuthViewModel()
    @State private var isInprogress = false
    @State private var showHomeView: Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Image("Onboarding")
                    .resizable()
                    .ignoresSafeArea()
                VStack(alignment: .leading){
                    HStack {
                        Button {
                            dismiss.callAsFunction()
                        } label: {
                            
                            
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .bold()
                        }
                        Text("Sign In")
                            .font(.ericaOne(size: 24))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.leading)
                    Text("Create account with easy and fast")
                        .foregroundStyle(.white)
                        .bold()
                        .padding(.leading, 35)
                }
                
                
                VStack(spacing: 10)  {
                    VStack(alignment: .leading) {
                        
                        Text("Email")
                            .font(.headline)
                            .foregroundStyle(.black)
                        TextField("Enter your email", text: $vm.email)
                            .keyboardType(.emailAddress)
                            .foregroundStyle(.black)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(30)
                            .padding(.bottom, 10)
                        
                        
                        Text("Password")
                            .font(.headline)
                            .foregroundStyle(.black)
                        SecureField("Enter your password", text: $vm.password)
                            .padding()
                            .foregroundStyle(.black)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.bottom, 10)
                    }
                    
                    .padding()
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.easeInOut) {
                            isInprogress = true
                            
                            Task {
                                do  {
                                    
                                    try await Task.sleep(nanoseconds: 3_000_000_000)
                                    try await vm.logIn()
                                    
                                    
                                    
                                    
                                    
                                    try await UserService.shared.fetchUser()
                                    print("DEBUG: User status \(UserService.shared.user.email)")
                                    
                                    
                                    
                                    
                                    
                                    isInprogress = false
                                    showHomeView = true
                                    
                                } catch (let error as AuthError)  {
                                    print("DEBUG: Error while sign Up \n \(error.errorDescription ?? "")")
                                    showHomeView = false
                                    isInprogress = false
                                    
                                } catch {
                                    print("DEBUG: Unexpetced error here \(error.localizedDescription)")
                                    isInprogress = false
                                    showHomeView = false
                                }
                            }
                        }
                        
                    } label:{
                        Group {
                            if isInprogress {
                                Spinner(lineWidth: 10, height: 30, width: 30)
                            } else {
                                Text("Sign In")
                            }
                        }
                        
                        .foregroundColor(.white)
                        .font(.ericaOne(size: 24))
                        .padding()
                        .frame(width: isInprogress ? 80 : 340)
                        .background(Color.greenApp)
                        .cornerRadius(40)
                    }
                    .padding(.bottom, 10)
                    
                    
                }
                .padding()
                .foregroundColor(.clear)
                .frame(width: 395, height: 698)
                .background(.white)
                .cornerRadius(40)
                .padding(.top, 70)
                
                
                .navigationBarBackButtonHidden()
            }
            .fullScreenCover(isPresented: $showHomeView) {
                ContainerView()
            }
         
        }
    }
}

#Preview {
    SignInView()
}
