import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ToddlerLockdownViewModel()
    @State private var showingAdminPanel = false
    @State private var adminPassword = ""
    
    var body: some View {
        ZStack {
            if viewModel.isLocked {
                LockedView(viewModel: viewModel)
            } else {
                VStack {
                    HStack {
                        Button(action: {
                            showingAdminPanel = true
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.blue)
                        }
                        .padding()
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Text("Toddler Lockdown")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.activateLockdown()
                    }) {
                        Text("Activate Lockdown")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showingAdminPanel) {
            AdminPanelView(viewModel: viewModel, isPresented: $showingAdminPanel)
        }
    }
}

struct LockedView: View {
    @ObservedObject var viewModel: ToddlerLockdownViewModel
    @State private var tapCount = 0
    @State private var lastTapTime = Date()
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Large colorful shapes for toddler engagement
                HStack(spacing: 20) {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 80, height: 80)
                        .onTapGesture {
                            playTapFeedback()
                        }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.yellow)
                        .frame(width: 80, height: 80)
                        .onTapGesture {
                            playTapFeedback()
                        }
                    
                    Circle()
                        .fill(Color.green)
                        .frame(width: 80, height: 80)
                        .onTapGesture {
                            playTapFeedback()
                        }
                }
                
                Text("LOCKED FOR TODDLER")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                HStack(spacing: 20) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.purple)
                        .frame(width: 80, height: 80)
                        .onTapGesture {
                            playTapFeedback()
                        }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.orange)
                        .frame(width: 80, height: 80)
                        .onTapGesture {
                            playTapFeedback()
                        }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.pink)
                        .frame(width: 80, height: 80)
                        .onTapGesture {
                            playTapFeedback()
                        }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func playTapFeedback() {
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
    }
}

#Preview {
    ContentView()
}
