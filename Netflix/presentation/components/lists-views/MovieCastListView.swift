//
//  MovieCastListView.swift
//  Notflix
//
//  Created by Quentin Eude on 16/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI
import Foundation
import Combine


struct MovieCastListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            MovieCastListView(movieId: 330457)
        }
    }
}



class MovieCastViewModel: ObservableObject {
    enum State {
        case initial
        case loading
        case error
        case data
    }

    @Published var actors = [Actor]()
    @Published var state: State = .initial

    private var disposables = Set<AnyCancellable>()

    init(movieId: Int) {
        fetchCastForMovie(movieId: movieId)
    }

    private func fetchCastForMovie(movieId: Int) {
        self.state = .loading
        APIClient().send(APIEndpoints.movieCredits(movieId: movieId)).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.actors = []
                self.state = .error
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.actors = Array(response.cast.sorted { $0.order < $1.order }.prefix(10))
            self.state = .data
        })
        .store(in: &disposables)

    }
}


struct MovieCastListView: View {
    @ObservedObject private var movieCastViewModel: MovieCastViewModel

    init(movieId: Int) {
        self.movieCastViewModel = MovieCastViewModel(movieId: movieId)
    }

    var castMemberDataIsDoneLoading: Bool {
        return movieCastViewModel.state != .loading
    }
    
    let spacing: CGFloat = 16
    let photoWidth: CGFloat = 100
    let scrollViewHeight: CGFloat = 150
    
    
    var body: some View {
        Group {
            if castMemberDataIsDoneLoading {
                VStack(alignment: .leading, spacing: spacing) {
                    sectionTitle
                    castList
                }
                .padding(.horizontal)
            }
            else {
                shimmerSkeleton
                    .padding(.horizontal)
            }
        }
    }
    
    var sectionTitle: some View {
        Text("Cast")
            .font(.system(size: 24, weight: .bold))
    }
    
    var shimmerSkeleton: some View {
        VStack(alignment: .leading, spacing: spacing) {
            ShimmerView()
                .frame(height: 32)
            ShimmerView()
                .frame(height: scrollViewHeight)
        }
        .padding(.horizontal)
    }

    var castList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacing) {
                Group {
                    ForEach(movieCastViewModel.actors) { castActor in
                        CastActorCell(castActor: castActor)
                    }
                }
            }
            .frame(height: scrollViewHeight)
          
        }
    }
    
}



struct CastActorCell: View {
    
    var castActor: Actor
    
    let spacing: CGFloat = 16
    let photoWidth: CGFloat = 100
    let scrollViewHeight: CGFloat = 150
    
    var body: some View {
        
        Group {
            if castActor.profileUrl != nil {
                VStack(alignment: .center, spacing: spacing) {
                    AsyncImage(url: castActor.profileUrl!,
                               configuration: { AnyView($0.resizable().scaledToFill()) },
                               defaultView: { AnyView(ShimmerView() )
                    })
                    .frame(width: photoWidth, height: photoWidth)
                    .clipShape(Circle())
                    
                    Text(castActor.name)
                        .font(.system(size: 15, weight: .medium))
                        .multilineTextAlignment(.center)
                        .frame(width: photoWidth)

                    Spacer(minLength: 0)
                }
            } else {
                emptyActorCell
            }
        }
        
    }
    
    
    var emptyActorCell: some View {
        VStack(alignment: .center, spacing: spacing) {
             Color.darkerGray
                 .frame(width: photoWidth, height: photoWidth)
                 .clipShape(Circle())
            
            Text(castActor.name)
                .font(.system(size: 15, weight: .medium))
                .multilineTextAlignment(.center)
                .frame(width: photoWidth)
            
            Spacer(minLength: 0)
         }
    }
}
