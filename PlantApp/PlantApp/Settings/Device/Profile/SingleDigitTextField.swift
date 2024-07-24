//
//  SingleDigitTextField.swift
//  PlantApp
//
//  Created by ProSkyMishka on 18.07.2024.
//

import SwiftUI

struct SingleDigitTextField: View {
    var index: Int
    @Binding var inputCode: [String]
    @Binding var isSubmitVisible: Bool
    @FocusState.Binding var focusedField: Int?
    
    var body: some View {
        TextField("", text: Binding(
            get: {
                return inputCode[index]
            },
            set: { newValue in
                if newValue.count <= 1, newValue.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
                    inputCode[index] = newValue
                    if newValue.count == 1 {
                        if index < 6 {
                            focusedField = index + 1
                        } else {
                            focusedField = nil
                        }
                    }
                    isSubmitVisible = inputCode.allSatisfy { $0.count == 1 }
                }
            }
        ))
        .frame(width: 30, height: 40)
        .font(.title)
        .multilineTextAlignment(.center)
        .keyboardType(.numberPad)
        .focused($focusedField, equals: index)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
        )
        .onChange(of: focusedField) { newValue in
            if newValue == index {
                DispatchQueue.main.async {
                    UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                }
            }
        }
    }
}
