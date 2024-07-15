//
//  DetailedScheduleView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct DetailedScheduleView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var flower: Plant
    
    var body: some View {
        
        ZStack {
            VStack (spacing: 30) {
                HStack(alignment: .top) {
                    Text("Detailed watering scehdule")
                        .foregroundColor(Theme.textBrown)
                        .font(.system(size: 25, weight: .bold))
                        .padding(.bottom, 5)
                }
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                .padding(.leading, 40)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 15) {
                        ForEach(flower.watering.filter({$0 <= Date()}), id: \.self) {date in
                            ZStack {
                                VStack (spacing: 0){
                                    Text(DateTimeFormatter.shared.toString(date: date))
                                        .font(.system(size: 15, weight: .bold))
                                        .frame(width: 49, height: 30)
                                        .foregroundStyle(.white)
                                        .background(.blue)
                                    Image(systemName: "drop.fill")
                                        .resizable()
                                        .frame(width: 17, height: 22)
                                        .padding()
                                        .background(.green)
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                    }
                }
                .defaultScrollAnchor(.trailing)
                VStack {
                    HStack {
                        Text("% moisture")
                            .foregroundColor(Theme.textBrown)
                            .font(.system(size: 25, weight: .bold))
                            .padding(.bottom, 15)
                    }
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    .padding(.leading, 45)
                    .padding(.top, 5)
                    HStack{
                        if Int(flower.humidity.prefix(2))!  < 20 {
                            Text(flower.humidity)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.red)
                            Text("Weak")
                                .font(.system(size: 28, weight: .bold))
                                .padding(.leading, 35)
                                .foregroundColor(.red)
                        } else if Int(flower.humidity.prefix(2))! < 30 {
                            Text(flower.humidity)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.blue)
                            Text("Normal")
                                .font(.system(size: 28, weight: .bold))
                                .padding(.leading, 35)
                                .foregroundColor(.blue)
                        } else {
                            Text(flower.humidity)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.green)
                            Text("Good")
                                .font(.system(size: 28, weight: .bold))
                                .padding(.leading, 35)
                                .foregroundColor(.green)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    .padding(.leading, 60)
                    .padding(.top, 5)
                }
                VStack {
                    HStack {
                        Text("Future watering")
                            .foregroundColor(Theme.textBrown)
                            .font(.system(size: 25, weight: .bold))
                            .padding(.bottom, 15)
                    }
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    .padding(.leading, 40)
                    .padding(.top, 5)
                    HStack{
                        if let date = flower.watering.filter({$0 > Date()}).first {
                            Text(DateTimeFormatter.shared.toString(date: date))
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(.primary)
                        } else {
                            Text("None")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(.primary)
                        }
                        
                    }
                    .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                    .padding(.leading, 60)
                    .padding(.top, 5)
                }
                HStack {
                    Text("Plan of watering")
                        .foregroundColor(Theme.textBrown)
                        .font(.system(size: 25, weight: .bold))
                        .padding(.bottom, 15)
                }
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                .padding(.leading, 40)
                .padding(.top, 5)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 15) {
                        ForEach(flower.watering.filter({$0 > Date()}), id: \.self) {date in
                            ZStack {
                                VStack (spacing: 0){
                                    Text(DateTimeFormatter.shared.toString(date: date))
                                        .font(.system(size: 15, weight: .bold))
                                        .frame(width: 49, height: 30)
                                        .foregroundStyle(.white)
                                        .background(.blue)
                                    Image(systemName: "drop.fill")
                                        .resizable()
                                        .frame(width: 17, height: 22)
                                        .padding()
                                        .background(.gray)
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                    }
                }
                .defaultScrollAnchor(.leading)
                Spacer()
            }
        }
        .padding(.top, 20)
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem(placement: .automatic) {
                Text(flower.name)
                    .foregroundColor(Theme.textGreen)
                    .font(.title2)
            }
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
                }
            }
        })
        .background(Theme.backGround)
    }
}
