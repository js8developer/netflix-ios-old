//
//  GenresList_TV.swift
//  Netflix
//
//  Created by Jason Schneider on 7/14/22.
//

import SwiftUI

struct GenresList_TV: View {
    
    @ObservedObject var homeManager_TV: HomeManager_TV

    var body: some View {
        
        VStack(alignment: .leading, spacing: 36) {
            
            ForEach(homeManager_TV.genres, id: \.id) { (genre) in
                
                Section_TV(sectionViewModel_TV: SectionViewModel_TV(fetcher: APIEndpoints.tvShowsForGenre(genreId: genre.id)),
                           title: genre.name)
            }
            
        }
        
    }
    
}
