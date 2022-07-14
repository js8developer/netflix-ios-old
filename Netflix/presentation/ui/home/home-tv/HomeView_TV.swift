//
//  HomeView_TV.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import Foundation
import SwiftUI


struct HomeView_TV_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            HomeView_TV()
        }
    }
}




struct HomeView_TV: View {
   
    @ObservedObject private var homeManager_TV: HomeManager_TV

    let spacing: CGFloat = 36
    
    init() {
        self.homeManager_TV = HomeManager_TV()
    }
    
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading, spacing: spacing) {
                
                ForEach(homeManager_TV.rows, id: \.id){ (row) in
                    Section_TV(sectionViewModel_TV: row.sectionViewModel_TV, title: row.title)
                }
                
                GenresList_TV(homeManager_TV: homeManager_TV)
            }
        }
    }
}



