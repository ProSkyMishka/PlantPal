//
//  Placeholder.swift
//  EventsWidget
//
//  Created by ProSkyMishka on 08.07.2024.
//

import SwiftUI

struct Placeholder: View {
    internal init(_ title: String) {
        self.title = title
    }
    
    private let title: String
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Text(title)
                    .font(.headline.weight(.medium))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding(.bottom, 15)
        }
        .overlay(alignment: .topLeading) {
            WidgetDate()
                .padding([.leading, .vertical], 12)
        }
    }
}
