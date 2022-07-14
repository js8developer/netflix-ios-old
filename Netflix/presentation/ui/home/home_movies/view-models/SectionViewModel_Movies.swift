//
//  SectionViewModel_Movies.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import Foundation
import Combine


class SectionViewModel_Movies: ObservableObject {
    enum State {
        case initial
        case loading
        case error
        case data
    }

    @Published var movies = [Movie]()
    @Published var state: State = .initial

    private var disposables = Set<AnyCancellable>()

    
    
    init(fetcher: APIRequest<APIResponseList<Movie>>) {
        self.fetchMovies(fetcher: fetcher)
    }

    
    
    private func fetchMovies(fetcher: APIRequest<APIResponseList<Movie>>) {
        self.state = .loading
        APIClient().send(fetcher).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.state = .error
                self.movies = []
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.state = .data
            self.movies = response.results
        })
        .store(in: &disposables)
    }
    
}
