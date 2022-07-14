//
//  HomeManager_Movies.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import Foundation
import Combine


class HomeManager_Movies: ObservableObject {
    enum State {
        case initial
        case loading
        case error
        case data
    }

    @Published var rows: [SectionModel_Movies] = [
        SectionModel_Movies(title: "Popular Movies", sectionViewModel_Movies: SectionViewModel_Movies(fetcher: APIEndpoints.popularMovies)),
        SectionModel_Movies(title: "Top Rated Movies", sectionViewModel_Movies: SectionViewModel_Movies(fetcher: APIEndpoints.topRatedMovies)),
    ]
    
    @Published var genres = [Genre]()
    @Published var state: State = .initial

    private var disposables = Set<AnyCancellable>()

    
    
    init() {
        self.fetchGenres()
    }

    
    
    private func fetchGenres() {
        self.state = .loading
        APIClient()
            .send(APIEndpoints.movieGenres)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure:
                    self.state = .error
                    self.genres = []
                case .finished:
                    break
                }
            }, receiveValue: { (response) in
                self.state = .data
                self.genres = Array(response.genres.shuffled().prefix(5))
            })
            .store(in: &disposables)
    }
}
