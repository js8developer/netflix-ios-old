//
//  RecommendationsView.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/13/22.
//

import SwiftUI


struct RecommendationsView: View {
    
    var netflixObject: NetflixObject
    
    func makeRecommendationsView(sectionTitle: String) -> some View {
        if let tvShow = netflixObject.tvShow {
            return AnyView(
                Section_TV(sectionViewModel_TV: SectionViewModel_TV(fetcher: APIEndpoints.recommendationsTVShows(tvShowId: tvShow.id)), title: sectionTitle)
            )
            
        }
        else if let movie = netflixObject.movie {
            return AnyView(
                Section_Movies(sectionViewModel_Movies: SectionViewModel_Movies(fetcher: APIEndpoints.recommendationsMovies(movieId: movie.id)), title: sectionTitle)
            )
        }
        return AnyView(EmptyView())
    }
    
    
    var body: some View {
        makeRecommendationsView(sectionTitle: "Recommendations")
    }
}


