//
//  NetflixObjectDetailsViewModel.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/13/22.
//

import Foundation
import SwiftUI


class NetflixObjectDetailsViewModel: ObservableObject {
    
    var netflixObject: NetflixObject
    @Published var tvShow: TVShow? = nil
    @Published var movie: Movie? = nil
    
    init(netflixObject: NetflixObject){
        self.netflixObject = netflixObject
        setValues()
    }
    
    func setValues(){
        if let movie = netflixObject.movie {
            self.movie = movie
        }
        else if let tvShow = netflixObject.tvShow {
            self.tvShow = tvShow
        }
    }
    
}


extension NetflixObjectDetailsViewModel {
    
    func getPosterURL() -> URL? {
        if let tvPoster = netflixObject.tvShow?.posterUrl {
            return tvPoster
        }
        else if let moviePoster = netflixObject.movie?.posterUrl {
            return moviePoster
        }
        return nil
    }
    
    func getTitle() -> String {
        if let tvShowTitle = netflixObject.tvShow?.title {
            return tvShowTitle
        }
        else if let movieTitle = netflixObject.movie?.title {
            return movieTitle
        }
        return "n/a"
    }
    
    func voteAverage() -> Double {
        if let tvShowVA = netflixObject.tvShow?.voteAverage {
            return tvShowVA
        }
        else if let movieVA = netflixObject.movie?.voteAverage {
            return movieVA
        }
        return 0.0
    }
    
    func overviewString() -> String {
        if let tvShowOverview = netflixObject.tvShow?.overview {
            return tvShowOverview
        }
        else if let movieOverview = netflixObject.movie?.overview {
            return movieOverview
        }
        return ""
    }
    
    func releaseDateString() -> String {
        if let firstAirYearToString = netflixObject.tvShow?.firstAirYearToString {
            return firstAirYearToString
        }
        else if let movieReleaseYearToString = netflixObject.movie?.releaseYearToString {
            return movieReleaseYearToString
        }
        return ""
    }

}
