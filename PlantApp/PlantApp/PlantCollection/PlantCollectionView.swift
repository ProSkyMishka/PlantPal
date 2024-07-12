//
//  PlantCollectionView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI
import SwiftData


struct PlantCollectionView: View {    
    @Environment(\.modelContext) var modelContext
    
    @StateObject var collectionViewModel = PlantCollectionViewModel()
    @State var flag = false
    @State var sorted_enabled: [Plant] = []
    @State private var offsets: [String: CGSize] = [:]
    @State private var showDeleteIcons: [String: Bool] = [:]
    @Binding var barHidden: Bool
    
    @Query
    var plants: [Plant]
    
    init(barHidden: Binding<Bool>) {
        _barHidden = barHidden
        collectionViewModel.plants = plants
        _plants = Query(filter: #Predicate { plant in
            return plant.serverId != ""
            }
        , sort: [])
    }
    
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
                    if showDeleteIcons[flower.serverId] == true && offsets[flower.serverId]?.width ?? 0 < 0 {
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
                                Image(uiImage: UIImage(data: flower.image ?? Data()) ?? UIImage())
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(20)
                                    .padding(.vertical, 25)
                                    .scaledToFit()
                                Spacer()
                            }
                            VStack {
                                Spacer()
                                Text(flower.name)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Theme.textGreen)
                                
                                Text(flower.desc)
                                    .font(.system(size: 18, weight: .light))
                                    .foregroundColor(Theme.description)
                            }
                            .tint(.black)
                            .padding(.vertical, 17)
                        }
                        .offset(x: offsets[flower.serverId]?.width ?? 0)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width < 0 {
                                        offsets[flower.serverId] = gesture.translation
                                        showDeleteIcons[flower.serverId] = true
                                    }
                                }
                                .onEnded { _ in
                                    if offsets[flower.serverId]?.width ?? 0 < -100 {
                                        withAnimation(.easeInOut) {
                                            if let index = collectionViewModel.plants.firstIndex(where: { $0.serverId == flower.serverId }) {
                                                offsets[flower.serverId] = .zero
                                                showDeleteIcons[flower.serverId] = false
                                                collectionViewModel.plants.remove(at: index)
                                            }
                                        }
                                    } else {
                                        withAnimation {
                                            offsets[flower.serverId] = .zero
                                            showDeleteIcons[flower.serverId] = false
                                        }
                                    }
                                }
                        )
                        .animation(.easeInOut, value: offsets[flower.serverId])
                    }
                    
                }
            }
            }
        }
    }
}
