//
//  HomeManager_TV.swift
//  Netflix
//
//  Created by Jason Schneider on 7/14/22.
//

import Foundation
import Combine


class HomeManager_TV: ObservableObject {
    enum State {
        case initial
        case loading
        case error
        case data
    }

    @Published var rows: [SectionModel_TV] = [
        SectionModel_TV(title: "Popular TV Shows", sectionViewModel_TV: SectionViewModel_TV(fetcher: APIEndpoints.popularTVShows)),
        SectionModel_TV(title: "Top Rated TV Shows", sectionViewModel_TV: SectionViewModel_TV(fetcher: APIEndpoints.topRatedTVShows)),
    ]
    
    @Published var genres = [Genre]()
    @Published var state: State = .initial

    private var cancellables = Set<AnyCancellable>()

    
    
    init() {
        self.fetchGenres()
    }

    
    
    private func fetchGenres() {
        self.state = .loading
        APIClient()
            .send(APIEndpoints.tvShowGenres)
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
            .store(in: &cancellables)
    }
}
