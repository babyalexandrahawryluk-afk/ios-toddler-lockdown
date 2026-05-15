import SwiftUI

struct AdminPanelView: View {
    @ObservedObject var viewModel: ToddlerLockdownViewModel
    @Binding var isPresented: Bool
    @State private var newPassword = ""
    @State private var passwordConfirm = ""
    @State private var showPasswordMismatch = false
    @State private var lockDurationMinutes: Double = 60
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Security")) {
                    SecureField("New Admin Password", text: $newPassword)
                    SecureField("Confirm Password", text: $passwordConfirm)
                    
                    Button(action: updatePassword) {
                        Text("Update Password")
                            .foregroundColor(.blue)
                    }
                    
                    if showPasswordMismatch {
                        Text("Passwords do not match")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                Section(header: Text("Lockdown Settings")) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Duration (minutes):")
                            Slider(value: $lockDurationMinutes, in: 5...480, step: 5)
                        }
                        Text("\(Int(lockDurationMinutes)) minutes")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: applyLockdownSettings) {
                        Text("Apply Settings")
                            .foregroundColor(.blue)
                    }
                }
                
                Section(header: Text("Deactivate Lockdown")) {
                    NavigationLink(destination: UnlockView(viewModel: viewModel, isPresented: $isPresented)) {
                        Text("Unlock Device")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Admin Panel")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
    
    private func updatePassword() {
        if newPassword == passwordConfirm && !newPassword.isEmpty {
            viewModel.updateAdminPassword(newPassword)
            newPassword = ""
            passwordConfirm = ""
            showPasswordMismatch = false
        } else {
            showPasswordMismatch = true
        }
    }
    
    private func applyLockdownSettings() {
        viewModel.lockDuration = lockDurationMinutes * 60
    }
}

struct UnlockView: View {
    @ObservedObject var viewModel: ToddlerLockdownViewModel
    @Binding var isPresented: Bool
    @State private var passwordInput = ""
    @State private var incorrectPassword = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Enter Admin Password")
                .font(.headline)
            
            SecureField("Password", text: $passwordInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if incorrectPassword {
                Text("Incorrect password")
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button(action: attemptUnlock) {
                Text("Unlock")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Unlock Device")
    }
    
    private func attemptUnlock() {
        if viewModel.deactivateLockdown(withPassword: passwordInput) {
            isPresented = false
        } else {
            incorrectPassword = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                incorrectPassword = false
            }
        }
    }
}

#Preview {
    AdminPanelView(viewModel: ToddlerLockdownViewModel(), isPresented: .constant(true))
}
