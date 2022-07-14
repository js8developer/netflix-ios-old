//
//  DetailsViewModel_TV.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import Foundation
import Combine

class DetailsViewModel_TV: ObservableObject {
    enum State {
        case initial
        case loading
        case error
        case data
    }

    @Published var tvShow: TVShow?
    @Published var state: State = .initial

    private var disposables = Set<AnyCancellable>()

    init(tvShowId: Int) {
        fetchTvShowDetails(tvShowId: tvShowId)
    }

    private func fetchTvShowDetails(tvShowId: Int) {
        self.state = .loading
        APIClient().send(APIEndpoints.tvShow(tvShowId: tvShowId)).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.tvShow = nil
                self.state = .error
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.tvShow = response
            self.state = .data
        })
        .store(in: &disposables)
    }
}
