//
//  PlantCollectionView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct PlantCollectionView: View {
    @State var plants: [PlantBaseModel] = [
        PlantBaseModel(name: "Apple", description: "Tree", lastWatered: Date(), url: "daisy", temperatureRange: "15 - 25", humidity: "65", waterInterval: 5, nextWatering: Date(), replay: .everyDay),
        PlantBaseModel(name: "Rosa", description: "Flower", lastWatered: Date(), url: "daisy", temperatureRange: "15 - 25", humidity: "65", waterInterval: 5, nextWatering: Date(), replay: .everyDay),
        PlantBaseModel(name: "Bereza", description: "Tree", lastWatered: Date(), url: "daisy", temperatureRange: "15 - 25", humidity: "65", waterInterval: 5, nextWatering: Date(), replay: .everyDay)
    ]
    
    @State var search = ""
    @State var flag = false
    @State var sorted_enabled: [PlantBaseModel] = []
    @Binding var barHidden: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    grid
                }
            }
            .navigationTitle("Flowers Collection")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        if !flag {
                            sorted_enabled = plants
                            plants.sort()
                        } else {
                            plants = sorted_enabled
                        }
                        flag = !flag
                    }, label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.horizontal, 10)
                            .foregroundColor(Color.blue)
                    })
                }
            }
            .searchable(text: $search)
            .searchSuggestions {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(plants) { suggestion in
                        if search.isEmpty || suggestion.name.lowercased().contains(search.lowercased()) || suggestion.name.maxSubstring(b: search) {
                            NavigationLink {
                                InformationForPlant(plant: suggestion, barHidden: $barHidden)
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .frame(width: 140, height: 180)
                                        .cornerRadius(20)
                                        .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.85))
                                        .padding(.vertical, 10)
                                    VStack {
                                        Rectangle()
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(20)
                                            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.65))
                                            .padding(.vertical, 25)
                                        Spacer()
                                    }
                                    VStack {
                                        Spacer()
                                        Text(suggestion.name)
                                            .font(.system(size: 20, weight: .bold))
                                        
                                        Text(suggestion.description)
                                            .font(.system(size: 18, weight: .light))
                                    }
                                    .tint(.black)
                                    .padding(.vertical, 17)
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    var grid: some View {
        LazyVGrid(columns: [GridItem(), GridItem()]) {
            ForEach($plants) { $flower in
            label: do {
                NavigationLink {
                    InformationForPlant(plant: flower, barHidden: $barHidden)
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 140, height: 180)
                            .cornerRadius(20)
                            .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.85))
                            .padding(.vertical, 10)
                        VStack {
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .cornerRadius(20)
                                .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.65))
                                .padding(.vertical, 25)
                            Spacer()
                        }
                        VStack {
                            Spacer()
                            Text(flower.name)
                                .font(.system(size: 20, weight: .bold))
                            
                            Text(flower.description)
                                .font(.system(size: 18, weight: .light))
                        }
                        .tint(.black)
                        .padding(.vertical, 17)
                    }
                }
                
            }
            }
        }
    }
}
