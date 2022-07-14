//
//  ContentView.swift
//  Netflix
//
//  Created by Jason Schneider on 7/14/22.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ContentView: View {
    
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
            
            
            SearchView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
            
        }
        .accentColor(.red)
        .preferredColorScheme(.dark)
    }
}
