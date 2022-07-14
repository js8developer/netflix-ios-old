//
//  SearchViewModel_Item.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/13/22.
//

import Foundation
import Combine

struct SearchViewModel_Item {
    enum SearchItemType {
        case tvShow
        case movie
    }
    
    var tvShow: TVShow?
    var movie: Movie?
    
    
    init(tvShow: TVShow) {
        self.type = .tvShow
        self.id = "\(tvShow.id)_\(self.type)"
        self.sourceId = tvShow.id
        self.title = tvShow.title
        self.posterPath = tvShow.posterPath
        self.popularity = tvShow.popularity
        
        self.tvShow = tvShow
    }

    init(movie: Movie) {
        self.type = .movie
        self.id = "\(movie.id)_\(self.type)"
        self.sourceId = movie.id
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.popularity = movie.popularity
        
        self.movie = movie
    }

    let id: String
    let sourceId: Int
    let type: SearchItemType
    let title: String
    let posterPath: String?
    let popularity: Double

    var posterUrl: URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        let url = URL(string: "\(APIClient.baseImageStringUrl)\(posterPath)")
        return url
    }
}
