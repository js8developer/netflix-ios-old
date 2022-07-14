//
//  GenresList_Movies.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import Foundation
import SwiftUI


struct GenresList_Movies: View {
   
    @ObservedObject var homeManager_Movies: HomeManager_Movies
    

    var body: some View {
        
        VStack(alignment: .leading, spacing: 36) {
            
            ForEach(homeManager_Movies.genres, id: \.id) { (genre) in
                
                Section_Movies(sectionViewModel_Movies: SectionViewModel_Movies(fetcher: APIEndpoints.moviesForGenre(genreId: genre.id)),
                           title: genre.name)
            }
            
        }
        
    }
}
