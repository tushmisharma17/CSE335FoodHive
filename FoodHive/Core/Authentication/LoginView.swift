//  LoginView.swift
//  FoodHive
//  Created by Tushmi Sharma on 10/29/24.

import SwiftUI
import SwiftData

struct LoginView: View {
    @Binding var isUserLoggedIn: Bool
    @Binding var currentUser: User?
    @State private var isLoginMode = true
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var errorMessage = ""
    @State private var showPassword = false
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationView {
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.5), Color.white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) {
                        Image("AppLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 200)
                            .padding(.top, 50)
                        
                        Text("Welcome to FoodHive")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 30)
                        
                        VStack(spacing: 15) {
                            if !isLoginMode {
                                TextField("First Name", text: $firstName)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                TextField("Last Name", text: $lastName)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                TextField("Phone Number", text: $phoneNumber)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                            }
                            TextField("Email", text: $email)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                                .keyboardType(.emailAddress)
                            
                            HStack {
                                if showPassword {
                                    TextField("Password", text: $password)
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(10)
                                } else {
                                    SecureField("Password", text: $password)
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(10)
                                }
                                Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 10)
                            }
                        }
                        .padding(.horizontal)
                        
                        Button(action: handleAction) {
                            Text(isLoginMode ? "Log In" : "Sign Up")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding()
                        
                        if isLoginMode {
                            HStack {
                                Text("Don't have an account?")
                                Button(action: {
                                    isLoginMode = false
                                }) {
                                    Text("Sign Up")
                                        .foregroundColor(.orange)
                                        .fontWeight(.bold)
                                }
                            }
                        } else {
                            HStack {
                                Text("Already have an account?")
                                Button(action: {
                                    isLoginMode = true
                                }) {
                                    Text("Log In")
                                        .foregroundColor(.orange)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                        
                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding(.horizontal)
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
            }
        }
    }

    private func handleAction() {
        if isLoginMode {
            
            do {
                let fetchDescriptor = FetchDescriptor<User>(predicate: #Predicate { user in
                    user.email == email && user.password == password
                })
                let users = try context.fetch(fetchDescriptor)
                if let user = users.first {
                    currentUser = user
                    isUserLoggedIn = true
                    errorMessage = ""
                } else {
                    errorMessage = "Invalid credentials. Please check your email and password."
                }
            } catch {
                errorMessage = "Error during login: \(error.localizedDescription)"
            }
        } else {
    
            
            do {
                let fetchDescriptor = FetchDescriptor<User>(predicate: #Predicate { user in
                    user.email == email
                })
                let existingUsers = try context.fetch(fetchDescriptor)
                if !existingUsers.isEmpty {
                    errorMessage = "An account with this email already exists."
                    return
                }
            } catch {
                errorMessage = "Error checking existing users: \(error.localizedDescription)"
                return
            }

            let newUser = User(
                email: email,
                password: password,
                firstName: firstName,
                lastName: lastName,
                phoneNumber: phoneNumber
            )
            context.insert(newUser)
            do {
                try context.save()
                errorMessage = "Account created! Please log in."
                isLoginMode = true
                
                firstName = ""
                lastName = ""
                phoneNumber = ""
                password = ""
            } catch {
                errorMessage = "Failed to create account: \(error.localizedDescription)"
            }
        }
    }
}
