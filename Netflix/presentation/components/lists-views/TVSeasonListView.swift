//
//  TVSeasonListView.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//


import SwiftUI
import Foundation
import Combine

struct TVSeasonListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            TVSeasonListView(tvShowId: 1402,
                             tvSeason: TVSeason(id: 3643,
                                                name: "Season 1",
                                                overview: "Rick Grimes embarks on a survivalist.",
                                                seasonNumber: 1, posterPath: "/yaOB2Y8GcoXwjNQ3apq67bMbNHF.jpg"))
        }
    }
}


class TVSeasonListViewModel: ObservableObject {
    @Published var episodes = [Episode]()

    private var disposables = Set<AnyCancellable>()
    private(set) var isLoading = false

    init(tvShowId: Int, tvSeasonNumber: Int) {
        load(tvShowId: tvShowId, tvSeasonNumber: tvSeasonNumber)
    }

    func load(tvShowId: Int, tvSeasonNumber: Int) {
        isLoading = true
        APIClient().send(APIEndpoints.tvSeason(tvShowId: tvShowId, tvSeasonNumber: tvSeasonNumber))
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure:
                    self.isLoading = false
                    self.episodes = []
                case .finished:
                    break
                }
            }, receiveValue: { (response) in
                self.isLoading = false
                self.episodes = response.episodes
            })
            .store(in: &disposables)
    }
}



struct TVSeasonListView: View {
    @ObservedObject private var tvSeasonListViewModel: TVSeasonListViewModel

    let tvSeasonName: String
    init(tvShowId: Int, tvSeason: TVSeason) {
        self.tvSeasonName = tvSeason.name
        self.tvSeasonListViewModel = TVSeasonListViewModel(tvShowId: tvShowId, tvSeasonNumber: tvSeason.seasonNumber)
    }
    
    var seasonTitleView: some View {
        return HStack {
                Text(tvSeasonName)
                    .font(.system(size: 18, weight: .bold))
                    
                Spacer()
            }
        
    }

    var episodesListView: some View {
        VStack {
            ForEach (tvSeasonListViewModel.episodes.sorted { $0.episodeNumber > $1.episodeNumber }, id: \.id) { episode in
                EpisodeCell(episode: episode)
            }
        }
    }
        
 
    var defaultShimmerGroup: some View {
        Group {
            ShimmerView().frame(height: 40)
                .padding(.top, 30)
            ForEach((1...5), id: \.self) { _ in
                ShimmerView()
                    .frame(height: 100)
            }
        }
    }
    
    
    var seasonHasEpisodes: Bool {
        return !self.tvSeasonListViewModel.episodes.isEmpty
    }
    
    
    
    var body: some View {
        Group {
            if seasonHasEpisodes {
                seasonTitleView
                episodesListView
            }
            else {
                defaultShimmerGroup
            }
        }
        .transition(
            AnyTransition.opacity
                .animation(.easeInOut(duration: 0.5))
        )
    }
}
