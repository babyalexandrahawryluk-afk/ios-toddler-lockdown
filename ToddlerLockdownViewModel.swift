import SwiftUI
import Combine

class ToddlerLockdownViewModel: NSObject, ObservableObject {
    @Published var isLocked = false
    @Published var lockDuration: TimeInterval = 3600 // 1 hour default
    @Published var adminPassword = "1234"
    @Published var allowedApps: [String] = []
    @Published var timeLimit: TimeInterval = 600 // 10 minutes default
    
    private var lockdownTimer: Timer?
    private var timeRemainingInSession: TimeInterval = 0
    
    func activateLockdown() {
        isLocked = true
        timeRemainingInSession = lockDuration
        
        // Disable all interactions except the lockdown screen
        disableSystemFeatures()
        
        // Start timer
        startLockdownTimer()
    }
    
    func deactivateLockdown(withPassword password: String) -> Bool {
        if password == adminPassword {
            isLocked = false
            lockdownTimer?.invalidate()
            enableSystemFeatures()
            return true
        }
        return false
    }
    
    private func startLockdownTimer() {
        lockdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.timeRemainingInSession -= 1
            
            if self.timeRemainingInSession <= 0 {
                self.deactivateLockdown(withPassword: "")
            }
        }
    }
    
    private func disableSystemFeatures() {
        // Disable home button interaction (in app)
        // This is handled through UIWindowSceneDelegate
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    private func enableSystemFeatures() {
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    func updateAdminPassword(_ newPassword: String) {
        adminPassword = newPassword
        saveToKeychain(newPassword)
    }
    
    func addAllowedApp(_ bundleID: String) {
        if !allowedApps.contains(bundleID) {
            allowedApps.append(bundleID)
        }
    }
    
    func removeAllowedApp(_ bundleID: String) {
        allowedApps.removeAll { $0 == bundleID }
    }
    
    private func saveToKeychain(_ password: String) {
        // Implement keychain storage for secure password storage
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "toddlerLockdownPassword",
            kSecValueData as String: password.data(using: .utf8) ?? Data()
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
}
