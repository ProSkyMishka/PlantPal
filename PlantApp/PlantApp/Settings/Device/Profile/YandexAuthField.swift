//
//  YandexAuthField.swift
//  PlantApp
//
//  Created by ProSkyMishka on 18.07.2024.
//

import SwiftUI

struct YandexAuthField: View {
    @Binding var isLogged: Bool
    @Binding var inputCode: [String]
    @Binding var showLeafFall: Bool
    @AppStorage ("AccessToken") var accessToken: String = ""
    @Binding var barHidden: Bool
    @Binding var showDevicesView: Bool
    @State private var isSubmitVisible = false
    @FocusState private var focusedField: Int?
    @State var path = NavigationPath()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                HStack(spacing: 10) {
                    ForEach(0..<7) { index in
                        SingleDigitTextField(index: index, inputCode: $inputCode, isSubmitVisible: $isSubmitVisible, focusedField: $focusedField)
                    }
                }
                .padding()
                
                if isSubmitVisible {
                    Button(action: {
                        Task {
                            await token()
                        }
                    }) {
                        Text("Submit")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200)
                            .background(Color.green)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(radius: 10)
            )
            .padding()
            
            Spacer()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                focusedField = 0
            }
        }
    }
    
    func getAccessToken(clientId: String, clientSecret: String, code: String, completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "https://oauth.yandex.ru/token"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        let credentials = "\(clientId):\(clientSecret)"
        let encodedCredentials = credentials.data(using: .utf8)!.base64EncodedString()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(encodedCredentials)", forHTTPHeaderField: "Authorization")

        let parameters = ["grant_type": "authorization_code", "code": code]
        request.httpBody = parameters.percentEncoded()

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response", code: -1, userInfo: nil)))
                return
            }

            if response.statusCode == 200 {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let accessToken = json?["access_token"] as? String {
                        completion(.success(accessToken))
                    } else {
                        completion(.failure(NSError(domain: "Missing access token", code: -1, userInfo: nil)))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "Invalid status code: \(response.statusCode)", code: -1, userInfo: nil)))
            }
        }
        task.resume()
    }
    
    func token() async {
        var code = ""
        for i in inputCode {
            code += i
        }
        
        getAccessToken(clientId: "d17748da1fcc46b1b7e1786cf43f9393", clientSecret: "2e37caa113f24f29b8128f2e3c82e2ae", code: code) { result in
            switch result {
            case .success(let accessToken):
                print("Access token: \(accessToken)")
                DispatchQueue.main.async {
                    UserDefaults.standard.set(accessToken, forKey: "AccessToken")
                    UserDefaults.standard.set(true, forKey: "Change")
                    isLogged = true
                    self.accessToken = accessToken
                    self.showDevicesView = true
                    barHidden.toggle()
                    dismiss()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}


extension Dictionary {
    func percentEncoded() -> Data? {
        return map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8)
    }
}

enum Path {
    case device
}
