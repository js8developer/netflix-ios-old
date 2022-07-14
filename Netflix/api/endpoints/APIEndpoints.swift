//
//  APIEndpoints.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import Foundation

struct APIEndpoints {}


// TVShows
extension APIEndpoints {
    static let popularTVShows = APIRequest<APIResponseList<TVShow>>(path: "tv/popular")
    static let topRatedTVShows = APIRequest<APIResponseList<TVShow>>(path: "tv/top_rated")
    static let tvShowGenres = APIRequest<APIResponseGenres>(path: "genre/tv/list")
    static func recommendationsTVShows(tvShowId: Int) -> APIRequest<APIResponseList<TVShow>> { return APIRequest(path: "tv/\(tvShowId)/recommendations") }
    static func tvShow(tvShowId: Int) -> APIRequest<TVShow> { return APIRequest(path: "tv/\(tvShowId)")}
    static func tvSeason(tvShowId: Int, tvSeasonNumber: Int) -> APIRequest<APIResponseTVSeason> { return APIRequest(path: "tv/\(tvShowId)/season/\(tvSeasonNumber)")}
    static func tvShowsForGenre(genreId: Int) -> APIRequest<APIResponseList<TVShow>> {
        return APIRequest(
            path: "discover/tv",
            parameters: [
                "with_genres": String(genreId)
            ]
        )
    }
    static func searchTVShows(for text: String) -> APIRequest<APIResponseList<TVShow>> {
           return APIRequest(
               path: "search/tv",
               parameters: [
                   "query": text
               ]
           )}
}



// Movies
extension APIEndpoints {
    static let popularMovies = APIRequest<APIResponseList<Movie>>(path: "movie/popular")
    static let topRatedMovies = APIRequest<APIResponseList<Movie>>(path: "movie/top_rated")
    static let movieGenres = APIRequest<APIResponseGenres>(path: "genre/movie/list")
    static func recommendationsMovies(movieId: Int) -> APIRequest<APIResponseList<Movie>> { return APIRequest(path: "movie/\(movieId)/recommendations") }
    static func movie(movieId: Int) -> APIRequest<Movie> { return APIRequest(path: "movie/\(movieId)")}
    static func moviesForGenre(genreId: Int) -> APIRequest<APIResponseList<Movie>> {
        return APIRequest(
            path: "discover/movie",
            parameters: [
                "with_genres": String(genreId)
            ]
        )
    }
    static func movieCredits(movieId: Int) -> APIRequest<APIResponseCredits> { return APIRequest(path: "movie/\(movieId)/credits")}
    static func searchMovies(for text: String) -> APIRequest<APIResponseList<Movie>> {
        return APIRequest(
            path: "search/movie",
            parameters: [
                "query": text
            ]
        )}
}
