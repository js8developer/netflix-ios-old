//
//  HomeView_Movies.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import SwiftUI

struct HomeView_Movies_Previews: PreviewProvider {
    static var previews: some View {
        HomeView_Movies()
    }
}


struct HomeView_Movies: View {
   
    @ObservedObject private var homeManager_Movies: HomeManager_Movies

    let spacing: CGFloat = 36
    
    
    init() {
        self.homeManager_Movies = HomeManager_Movies()
    }
    

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            
            VStack(spacing: spacing) {
                
                ForEach(homeManager_Movies.rows, id: \.id){ (row) in
                    Section_Movies(sectionViewModel_Movies: row.sectionViewModel_Movies, title: row.title)
                }
                
                GenresList_Movies(homeManager_Movies: homeManager_Movies)
            }
        
        }
    }
}


