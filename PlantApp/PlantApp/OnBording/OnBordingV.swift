//
//  OnBordingV.swift
//  PlantApp
//
//  Created by Михаил Прозорский on 17.07.2024.
//

import SwiftUI

struct OnBoardingD: Identifiable, Hashable {
    var id = UUID()
    var image: String
    var height, width: CGFloat
    var title, description: String
}

struct OnBordingV: View {
    var data: OnBoardingD
    var body: some View {
        VStack {
            Image(systemName: data.image)
                .resizable()
                .frame(width: data.width, height: data.height)
                .padding(.vertical, 24)
                .frame(width: 395)
                .foregroundColor(Theme.textBrown)

                Text(LocalizedStringKey(data.title)).font(.system(size: 45, weight: .heavy))
                    .padding(.bottom, 4)
                    .frame(width: 375)
                    .foregroundColor(Theme.textBrown)
            Text(LocalizedStringKey(data.description))
                .frame(width: 350)
                .font(.system(size: 24))
                .foregroundStyle(Theme.description)
            Spacer()
        }
        .ignoresSafeArea()
        .frame(width: UIScreen.main.bounds.width/*, height: UIScreen.main.bounds.height*/)
        .background(Theme.backGround)
    }
}


