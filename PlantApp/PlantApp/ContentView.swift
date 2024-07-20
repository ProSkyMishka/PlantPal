//
//  ContentView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(EventStore.self) private var eventStore
    @State var index = 0
    @State var barHidden = false
    @State var path = NavigationPath()
    
    var body: some View {
        if !eventStore.canAccessEvents {
            ContentUnavailableView {
                Button("Request Access") {
                    Task {
                        await eventStore.requestAccess()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        VStack {
            switch index {
            case 0:
                PlantCollectionView(barHidden: $barHidden)
            case 1:
                AddPlantView(path: $path, index: $index, barHidden: $barHidden)
            case 2:
                SettingsView(barHidden: $barHidden, path: $path, index: $index)
            default:
                Text("AAA")
            }
            Spacer()
            
            if !barHidden {
                TabBar(index: $index)
            }
        }
        .background(Theme.backGround)
        .animation(.spring, value: barHidden)
        .padding([.bottom])
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
