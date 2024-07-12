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
    @State private var offsets: [UUID: CGSize] = [:]
    @State private var showDeleteIcons: [UUID: Bool] = [:]
    @Binding var barHidden: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    grid
                }
            }
            .background(Theme.backGround)
            .toolbar {
                ToolbarItem {
                    Text("Flowers Collection")
                      .font(.system(size: 30))
                      .bold()
                      .foregroundColor(Theme.textAzure)
                }
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
                            .background(Theme.backGround)
                    })
                }
            }
            .foregroundColor(Theme.textBrown)
            .searchable(text: $collectionViewModel.search)
        }
    }
    
    var grid: some View {
        LazyVGrid(columns: [GridItem(), GridItem()]) {
            ForEach(collectionViewModel.filteredPlants) { flower in
            label: do {
                ZStack {
                    if showDeleteIcons[flower.id] == true && offsets[flower.id]?.width ?? 0 < 0 {
                        Image(systemName: "trash.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                            .padding()
                        //   .transition(.move(edge: .trailing))
                        //   .animation(.easeInOut(duration: 0.1), value: showDeleteIcons[flower.id])
                    }
                    NavigationLink {
                        InformationForPlant(plant: flower, barHidden: $barHidden)
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 140, height: 180)
                                .cornerRadius(20)
                                .foregroundColor(Theme.pink)
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
                                    .foregroundColor(Theme.textGreen)
                                
                                Text(flower.description)
                                    .font(.system(size: 18, weight: .light))
                                    .foregroundColor(Theme.description)
                            }
                            .tint(.black)
                            .padding(.vertical, 17)
                        }
                        .offset(x: offsets[flower.id]?.width ?? 0)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width < 0 {
                                        offsets[flower.id] = gesture.translation
                                        showDeleteIcons[flower.id] = true
                                    }
                                }
                                .onEnded { _ in
                                    if offsets[flower.id]?.width ?? 0 < -100 {
                                        withAnimation(.easeInOut) {
                                            if let index = collectionViewModel.plants.firstIndex(where: { $0.id == flower.id }) {
                                                offsets[flower.id] = .zero
                                                showDeleteIcons[flower.id] = false
                                                collectionViewModel.plants.remove(at: index)
                                            }
                                        }
                                    } else {
                                        withAnimation {
                                            offsets[flower.id] = .zero
                                            showDeleteIcons[flower.id] = false
                                        }
                                    }
                                }
                        )
                        .animation(.easeInOut, value: offsets[flower.id])
                    }
                    
                }
            }
            }
        }
    }
}
