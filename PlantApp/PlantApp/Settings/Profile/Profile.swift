import SwiftUI
import AuthenticationServices
import Foundation

struct Profile: View {
    @Binding var barHidden: Bool
    @Binding var isLogged: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var showYandexAuthField = false
    @State private var inputCode = Array(repeating: "", count: 7)
    @State private var showLeafFall = false
    @State private var showDevicesView = false

    var body: some View {
        ZStack {
            // Background with flowers and gradient
            LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.6), Color.blue.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Title
                Text("Welcome to PlantPal")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                
                // Subtitle
                Text("Nurture your plants with ease")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom, 20)
                
                // Yandex Auth Button
                Button(action: {
                    // Open Yandex authorization URL
                    if let url = URL(string: "https://oauth.yandex.ru/authorize?response_type=code&client_id=d17748da1fcc46b1b7e1786cf43f9393&force_confirm=no&scope=iot:view%20iot:control") {
                        UIApplication.shared.open(url) { success in
                            if success {
                                // Simulate a callback from Yandex authorization
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        showYandexAuthField = true
                                    }
                                }
                            }
                        }
                    }
                }) {
                    VStack {
                        Image("logo_id_new")
                            .resizable()
                            .frame(width: 270, height: 100)
                            .foregroundColor(.green)
                        
                        Text("Sign in with Yandex")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.8))
                            .shadow(radius: 10)
                    )
                }
                .padding(.bottom, 20)
            }
            .padding()
            
            VStack {
                Spacer()
                // Footer
                HStack {
                    Image(systemName: "leaf")
                        .foregroundColor(.white)
                    Text("PlantPal © 2024")
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.bottom, 20)
            }
            
            if showYandexAuthField {
                YandexAuthField(isLogged: $isLogged, inputCode: $inputCode, showLeafFall: $showLeafFall, barHidden: $barHidden, showDevicesView: $showDevicesView)
                    .transition(.move(edge: .bottom))
            }
            
//            NavigationLink(destination: DevicesView(), isActive: $showDevicesView) {
//                
//            }
        }
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Theme.icon)
                    
                    Text("Back")
                        .font(.system(size: 20))
                        .foregroundColor(Theme.icon)
                }
                .onTapGesture {
                    dismiss()
                    barHidden = false
                }
            }
        })
    }
}
