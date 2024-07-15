//
//  FlowerListView.swift
//  PlantApp
//
//  Created by Lucy Rez on 14.07.2024.
//

import SwiftUI
import SwiftData

struct FlowerListView: View {
    @Environment(\.modelContext) var modelContext: ModelContext
    
    @State private var offsets: [String: CGSize] = [:]
    @State private var showDeleteIcons: [String: Bool] = [:]
    @Binding var barHidden: Bool
    @Binding var search: String
    
    @Query
    var plants: [Plant]
    
    var filteredPlants: [Plant] {
        guard !search.isEmpty else {return plants}
        return plants.filter { plant in
            plant.name.lowercased().contains(search.lowercased()) || plant.name.maxSubstring(b: search)
        }
    }
    
    init(sort: [SortDescriptor<Plant>], search: Binding<String>, barHidden: Binding<Bool>) {
        _plants = Query(sort: sort)
        _barHidden = barHidden
        _search = search
    }
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem()]) {
            ForEach(filteredPlants) { flower in
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
                                .frame(width: 140, height: 170)
                                .cornerRadius(20)
                                .foregroundColor(Theme.pink)
                                .padding(.vertical, 10)
                            VStack {
                                Image(uiImage: UIImage(data: flower.image ?? Data()) ?? UIImage())
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(20)
                                    
                                    .scaledToFit()
                                
                                Text(flower.name)
                                    .padding(.vertical, 4)
                                
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Theme.textGreen)
                               
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
                                            if let index = plants.firstIndex(where: { $0.serverId == flower.serverId }) {
                                                offsets[flower.serverId] = .zero
                                                showDeleteIcons[flower.serverId] = false
                                                // Вызвать delete
                                                modelContext.delete(plants[index])
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
