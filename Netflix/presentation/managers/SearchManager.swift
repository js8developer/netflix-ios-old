//
//  SearchManager.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/13/22.
//

import Foundation
import Combine


class SearchManager: ObservableObject {
    enum State {
        case initial
        case loading
        case error
        case data
    }

    @Published var searchText = ""
    @Published var items = [[SearchViewModel_Item]]()
    @Published var state: State = .initial

    private var cancellables = Set<AnyCancellable>()

    
    init() {
        $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { searchText in
                if !searchText.isEmpty {
                    self.performSearch(for: searchText)
                } else {
                    self.items = []
                }
        }.store(in: &cancellables)
    }
    
    

    func performSearch(for text: String) {
        self.state = .loading
        self.items = []
        var movies = [SearchViewModel_Item]()
        var tvShows = [SearchViewModel_Item]()
        APIClient().send(APIEndpoints.searchMovies(for: text)).mapError { error -> Error in
            self.state = .error
            self.items = []
            return error
        }
        .flatMap { response -> AnyPublisher<APIResponseList<TVShow>, Error> in
            movies = response.results.map { SearchViewModel_Item(movie: $0)}
            return APIClient().send(APIEndpoints.searchTVShows(for: text))
        }
        .mapError { error -> Error in
            self.state = .error
            self.items = []
            return error
        }
        .map { response -> [SearchViewModel_Item] in
            tvShows = response.results.map { SearchViewModel_Item(tvShow: $0)}
            let concatItems = tvShows + movies
            if concatItems.isEmpty {
                self.state = .data
                self.items = []
            }
            return concatItems.sorted { $0.popularity > $1.popularity }
        }
        .flatMap { $0.publisher.setFailureType(to: Error.self) }
        .collect(3)
        .sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.state = .error
                self.items = []
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.state = .data
            self.items += Array(arrayLiteral: response)
        })
        .store(in: &cancellables)
    }
    
    
}
