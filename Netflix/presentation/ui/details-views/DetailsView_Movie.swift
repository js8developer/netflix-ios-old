//
//  DetailsView_Movie.swift
//  Notflix
//
//  Created by Quentin Eude on 15/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct DetailsView_Movie_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView_Movie(movieId: 330457)
    }
}



struct DetailsView_Movie: View {
    
    
    @ObservedObject private var detailsViewModel_Movie: DetailsViewModel_Movie
    
    var netflixObject: NetflixObject {
        return NetflixObject(type: .movie, movie: detailsViewModel_Movie.movie)
    }
    
    let headerSpacing: CGFloat = 20
    
    
    init(movieId: Int) {
        UIScrollView.appearance().bounces = false
        
        self.detailsViewModel_Movie = DetailsViewModel_Movie(movieId: movieId)
    }
    
    

    var body: some View {
        ZStack {
            Color(.black)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: headerSpacing) {
                    header
                    cast
                    recommendations
                }
            }
            .edgesIgnoringSafeArea(.all)
            .foregroundColor(.primary)
        }
    }
    
    
    
    

    
    var header: some View {
        ZStack {
            BlurredHeaderView(netflixObjectDetailsViewModel: NetflixObjectDetailsViewModel(netflixObject: netflixObject))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 500, alignment: .topLeading)
        .clipped()
    }


    var cast: some View {
        Group {
            self.detailsViewModel_Movie.movie.map { movie in
                MovieCastListView(movieId: movie.id)
            }
        }
    }

    var recommendations: some View {
        RecommendationsView(netflixObject: netflixObject)
            .padding(.bottom, 90)
    }
}
