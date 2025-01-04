//
//  SignUpView.swift
//  SWE_Project
//
//  Created by Khalid R on 06/03/1446 AH.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var vm: AuthViewModel = AuthViewModel()
    @State private var isInprogress: Bool = false
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
                        Text("Sign Up")
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
                        // Username Label and Field
                        Text("Username")
                            .font(.headline)
                            .foregroundStyle(.black)
                        TextField("Enter your username", text: $vm.userName)
                            .foregroundStyle(.black)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(30)
                            .padding(.bottom, 10)
                        
                        // Email Label and Field
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
                        
                        // Password Label and Field
                        Text("Password")
                            .font(.headline)
                            .foregroundStyle(.black)
                        SecureField("Enter your password", text: $vm.password)
                            .foregroundStyle(.black)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.bottom, 10)
                    }
                    
                    .padding()
               
                               Spacer()
                               
                               Button(action: {
                                   
                                   withAnimation(.easeInOut) {
                                       isInprogress = true
                                       
                                       Task {
                                           do  {
                                               
                                               try await Task.sleep(nanoseconds: 3_000_000_000)
                                               try await vm.createUser()
                                               
                                               
                                               
                                               
                                               
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
                                   }                           }) {
                                   Group {
                                       if isInprogress {
                                           Spinner(lineWidth: 10, height: 30, width: 30)
                                       } else {
                                           Text("Sign Up")
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

                               
                               HStack {
                                   Text("Already have an account?")
                                       .font(.system(size: 14))
                                       .foregroundStyle(.black)
                                   Button(action: {
                                       
                                   }) {
                                       Text("Sign Up")
                                           .font(.system(size: 14))
                                           .foregroundColor(.blue)
                                   }
                               }
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
    SignUpView()
}
