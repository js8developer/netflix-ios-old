//
//  MovieCell.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import SwiftUI

struct MovieCell: View {

    var movie: Movie

    var body: some View {
        
        NavigationLink(destination: NetflixObjectDetailsView(netflixObject: NetflixObject(type: .movie, movie: movie))){
            
            Group {
                NetflixObjectPosterView(posterUrl: movie.posterUrl, titleString: movie.title)
            }
            
        }
        
    }
    
}
