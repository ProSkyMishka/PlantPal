//
//  PlantCollectionView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI
import SwiftData


struct PlantCollectionView: View {    
    @Environment(\.modelContext) private var modelContext: ModelContext
    @State var sortAlphabet: Bool = false
    @State var sorted_enabled: [Plant] = []
    @State var search = ""
    @Binding var barHidden: Bool
    @FocusState var isFocused: Bool
    @State var showSearch: Bool = false
    

    var body: some View {
        NavigationStack {
            VStack {
                if (!showSearch) {
                    HStack {
                        
                        Text("Flowers Collection")
                            .font(.system(size: 30))
                            .bold()
                            .foregroundColor(Theme.textAzure)
                        
                        Spacer()
                        
                        Button(action: {
                            sortAlphabet.toggle()
                        }, label: {
                            Image(systemName: "arrow.up.arrow.down")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.horizontal, 10)
                                .background(Theme.backGround)
                        })
                    }
                }
                
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Theme.textColor)
                        
                        TextField("", text: $search, prompt: Text("Search").foregroundColor(Theme.textColor))
                            .foregroundColor(Theme.textColor)
                            .font(.system(size: 20))
                            .onChange(of: isFocused) {
                                withAnimation {
                                    showSearch = isFocused
                                }
                            }
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(Theme.search)
                    .cornerRadius(10)
                    .focused($isFocused)
                    
                    if (showSearch) {
                        Button(action: {
                            withAnimation {
                                isFocused = false
                            }
                           
                        }) {
                            Text("Cancel")
                                .foregroundColor(Theme.icon)
                                .font(.system(size: 20))
                        }
                    }
                }
                .transition(.slide)

                ScrollView {
                    ZStack {
                        FlowerListView(sort: sortAlphabet ? [SortDescriptor(\Plant.name)] : [], filter: #Predicate { plant in
                            if search != "" {
                                plant.name.localizedStandardContains(search) /*|| plant.maxSubstring(b: search)*/
                            } else {
                                return true
                            }
                            
                        }, barHidden: $barHidden)
                    }
                }
            }
//            .onAppear {
//                let plant = Plant(serverId: "1003", desc: "Description", humidity: "45-56", temp: "45", MLID: "038", imageURL: "", seconds: 56, name: "Test")
//                plant.image = UIImage(systemName: "star.fill")?.jpegData(compressionQuality: 1.0)!
//                plant.watering = [Date(), Date(timeInterval: 60, since: Date()), Date(timeInterval: -60, since: Date()), Date(timeInterval: 3600, since: Date())]
//                modelContext.insert(plant)
//            }
            .transition(.slide)
            .padding(.horizontal)
            .background(Theme.backGround)
            .foregroundColor(Theme.textBrown)
        }
    }

    
}
