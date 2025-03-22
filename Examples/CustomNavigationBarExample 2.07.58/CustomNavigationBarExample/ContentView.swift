//
//  ContentView.swift
//  CustomNavigationBarExample
//  
//  Created by Chronos2500 on 2025/03/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("AppStore Style"){
                    AppStoreView()
                }
                NavigationLink("MusicApp Style"){

                }
                NavigationLink("Usage in List"){

                }
            }
            .navigationTitle("Example")
        }
    }
}

#Preview {
    ContentView()
}
