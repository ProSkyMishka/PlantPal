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
    
    var body: some View {
        VStack {
            switch index {
            case 0:
                PlantCollectionView()
            case 1:
                AddPlantView()
            case 2:
                SettingsView(barHidden: $barHidden)
            default:
                Text("AAA")
            }
            
            Spacer()
            
            if !barHidden {
                TabBar(index: $index)
            }
        }
        .padding([.bottom, .leading, .trailing])
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
