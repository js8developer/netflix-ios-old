//
//  DetailsViewModel_Movie.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import Foundation
import Combine

class DetailsViewModel_Movie: ObservableObject {
    enum State {
        case initial
        case loading
        case error
        case data
    }

    @Published var movie: Movie?
    @Published var state: State = .initial

    private var disposables = Set<AnyCancellable>()

    init(movieId: Int) {
        fetchMovieDetails(movieId: movieId)
    }

    private func fetchMovieDetails(movieId: Int) {
        self.state = .loading
        APIClient().send(APIEndpoints.movie(movieId: movieId)).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.movie = nil
                self.state = .error
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.movie = response
            self.state = .data
        })
        .store(in: &disposables)
    }
}
