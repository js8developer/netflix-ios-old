//
//  SectionViewModel_TV.swift
//  Netflix
//
//  Created by Jason Schneider on 7/14/22.
//

import Foundation
import Combine


class SectionViewModel_TV: ObservableObject {
    
    enum State {
        case initial
        case loading
        case error
        case data
    }

    @Published var tvShows = [TVShow]()
    @Published var state: State = .initial

    private var disposables = Set<AnyCancellable>()

    
    
    init(fetcher: APIRequest<APIResponseList<TVShow>>) {
        self.fetchTVShows(fetcher: fetcher)
    }

    
    
    private func fetchTVShows(fetcher: APIRequest<APIResponseList<TVShow>>) {
        self.state = .loading
        APIClient().send(fetcher).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.state = .error
                self.tvShows = []
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.state = .data
            self.tvShows = response.results
        })
        .store(in: &disposables)
    }
    
}
