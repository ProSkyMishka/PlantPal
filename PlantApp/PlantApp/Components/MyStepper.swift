//
//  Stepper.swift
//  PlantApp
//
//  Created by ProSkyMishka on 19.07.2024.
//

import SwiftUI

struct MyStepper: View {
    @Binding var value: Int
    var onChange: () -> Void
    var minValue: Int = 0
    var maxValue: Int = 30
    var step: Int = 1
    
    var body: some View {
        HStack {
            Button {
                if value - step >= minValue {
                    value -= step
                    onChange()
                }
            } label: {
                Text("-")
            }
            
            Text("\(value)")
            
            Button {
                if value + step <= maxValue {
                    value += step
                    onChange()
                }
            } label: {
                Text("+")
            }
        }
        .font(.system(size: 20, weight: .bold))
        .foregroundColor(Theme.textBrown)
    }
}

