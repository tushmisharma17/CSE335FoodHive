//  EditProfileView.swift
//  FoodHive
//  Created by Tushmi Sharma on 11/28/24.

import SwiftUI
import SwiftData

struct EditProfileView: View {
    @Binding var currentUser: User?
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var defaultAddress = ""
    @State private var errorMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Info").foregroundColor(.orange)) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }

                Section(header: Text("Contact Info").foregroundColor(.orange)) {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                }

                Section(header: Text("Address").foregroundColor(.orange)) {
                    TextField("Default Address", text: $defaultAddress)
                }

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveProfile()
                }
            )
            .onAppear {
                loadUserData()
            }
        }
    }

    private func loadUserData() {
        if let user = currentUser {
            firstName = user.firstName
            lastName = user.lastName
            email = user.email
            phoneNumber = user.phoneNumber
            defaultAddress = user.defaultAddress
        }
    }

    private func saveProfile() {
        guard let user = currentUser else {
            errorMessage = "User data not available."
            return
        }

        // Update user properties
        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        user.phoneNumber = phoneNumber
        user.defaultAddress = defaultAddress

        do {
            try context.save()
            errorMessage = ""
            presentationMode.wrappedValue.dismiss()
        } catch {
            errorMessage = "Failed to save profile: \(error.localizedDescription)"
        }
    }
}
