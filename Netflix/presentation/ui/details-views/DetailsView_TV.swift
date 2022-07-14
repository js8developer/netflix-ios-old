//
//  DetailsView_TV.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import SwiftUI
import Combine


struct DetailsView_TV: View {
    
    @ObservedObject private var detailsViewModel_TV: DetailsViewModel_TV

    var netflixObject: NetflixObject {
        return NetflixObject(type: .tv, tvShow: tvShow)
    }
    
    let headerSpacing: CGFloat = 20
    
    var tvShow: TVShow
    
    init(tvShow: TVShow) {
        UIScrollView.appearance().bounces = false
        self.tvShow = tvShow
        self.detailsViewModel_TV = DetailsViewModel_TV(tvShowId: tvShow.id)
    }

    
    
    
    var body: some View {
        ZStack {
    
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: headerSpacing) {
                    header
                    episodes
                    recommendations
                }
            }
            .edgesIgnoringSafeArea(.all)
            
        }
    }
    
    
    
    var header: some View {
        ZStack {
            BlurredHeaderView(netflixObjectDetailsViewModel: NetflixObjectDetailsViewModel(netflixObject: netflixObject))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 500, alignment: .topLeading)
        .clipped()
    }

    var episodes: some View {
        SeasonsSection(tvShow: tvShow, detailsViewModel_TV: detailsViewModel_TV)
    }

    var recommendations: some View {
        RecommendationsView(netflixObject: netflixObject)
            .padding(.bottom, 90)
    }
}












struct SeasonsSection: View {
    
    var tvShow: TVShow
    @ObservedObject var detailsViewModel_TV: DetailsViewModel_TV
    
    @State var seasons: [TVSeason] = []
    
    init(tvShow: TVShow, detailsViewModel_TV: DetailsViewModel_TV){
        self.detailsViewModel_TV = detailsViewModel_TV
        self.tvShow = tvShow
        
        print("⭐️")
        print(tvShow)
        print("⭐️")
        
        if let seasons = tvShow.seasons {
            self.seasons = seasons
            print("Seasons")
            print(seasons)
        }
       
     
    }

    var body: some View {
        
        ZStack {

            VStack {
                HStack {
                    Text("Seasons")
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                }
                .frame(width: fullWidth - 32)
                
                episodes
            }
            
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .padding(.bottom, 10)
        .clipped()
    
    }
    
    
    
    var episodes: some View {
        Group {
            detailsViewModel_TV.tvShow.map { tvShow in
                tvShow.seasons.map { tvSeasons in
                        ForEach(tvSeasons.sorted {$0.seasonNumber > $1.seasonNumber}, id: \.id) { season in
                                TVSeasonListView(tvShowId: tvShow.id, tvSeason: season)
                    }
                    .frame(maxHeight: .infinity)
                }
            }
        }
        .padding(.top, 8)
        .padding([.leading, .trailing, .bottom], 16)
    }
    
}







// // // /


//class SeasonCardViewModel: ObservableObject {
//    @Published var episodes = [Episode]()
//
//    private var disposables = Set<AnyCancellable>()
//    private(set) var isLoading = false
//
//    init(tvShowId: Int, tvSeasonNumber: Int) {
//        load(tvShowId: tvShowId, tvSeasonNumber: tvSeasonNumber)
//    }
//
//    func load(tvShowId: Int, tvSeasonNumber: Int) {
//        isLoading = true
//        APIClient().send(APIEndpoints.tvSeason(tvShowId: tvShowId, tvSeasonNumber: tvSeasonNumber))
//            .sink(receiveCompletion: { (completion) in
//                switch completion {
//                case .failure:
//                    self.isLoading = false
//                    self.episodes = []
//                case .finished:
//                    break
//                }
//            }, receiveValue: { (response) in
//                self.isLoading = false
//                self.episodes = response.episodes
//            })
//            .store(in: &disposables)
//    }
//}

//
//struct SeasonCard: View {
//
//    @ObservedObject private var seasonCardViewModel: SeasonCardViewModel
//
//    var tvSeason: TVSeason
//
//    init(tvShowId: Int, tvSeason: TVSeason) {
//        self.seasonCardViewModel = SeasonCardViewModel(tvShowId: tvShowId, tvSeasonNumber: tvSeason.seasonNumber)
//        self.tvSeason = tvSeason
//    }
//
//
//    var body: some View {
//
//        VStack(alignment: .leading) {
//            Text("Season \(tvSeason.seasonNumber)")
//
//            VStack {
//                ForEach(seasonCardViewModel.episodes, id: \.id){ (episode) in
//                    EpisodeCell(episode: episode)
//                }
//            }
//        }
//        .padding()
//        .background(Color.orange)
//        .cornerRadius(10)
//
//    }
//}
//
