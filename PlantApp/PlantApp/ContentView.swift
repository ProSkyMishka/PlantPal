//
//  ContentView.swift
//  PlantApp
//
//  Created by Lucy Rez on 08.07.2024.
//

import SwiftUI

struct ContentView: View {
    @State var index = 0
    @State var barHidden = false
    @State var path = NavigationPath()
    @State var theme = Theme.shared
    
    var body: some View {
        VStack {
            switch index {
            case 0:
                PlantCollectionView(barHidden: $barHidden)
            case 1:
                AddPlantView(barHidden: $barHidden)
            case 2:
                SettingsView(barHidden: $barHidden, path: $path)
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
