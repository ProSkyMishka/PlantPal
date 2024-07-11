//
//  PlantCollectionView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct PlantCollectionView: View {    
    @StateObject var collectionViewModel = PlantCollectionViewModel()
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
                            sorted_enabled = collectionViewModel.plants
                            collectionViewModel.plants.sort()
                        } else {
                            collectionViewModel.plants = sorted_enabled
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
            .searchable(text: $collectionViewModel.search)
        }
    }
    
    var grid: some View {
        LazyVGrid(columns: [GridItem(), GridItem()]) {
            ForEach(collectionViewModel.filteredPlants) { flower in
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
