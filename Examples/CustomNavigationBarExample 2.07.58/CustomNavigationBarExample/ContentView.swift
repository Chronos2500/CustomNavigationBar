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
                Section{
                    NavigationLink("AppStore Style"){
                        AppStoreView()
                    }
                    NavigationLink("MusicApp Style 1"){
                        MusicAppView1()
                    }
                    NavigationLink("MusicApp Style 2"){
                        MusicAppView2()

                    }
                } footer: {
                    Text("Please take a look for reference, as this is a simple UI implementation.")
                }

            }
            .navigationTitle("Demo")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ContentView()
}
