//
//  NetflixObjectDetailsView.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/13/22.
//

import SwiftUI

struct NetflixObjectDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NetflixObjectDetailsView(netflixObject: NetflixObject(type: .movie, movie: frozen2Movie))
    }
}


struct NetflixObjectDetailsView: View {
    
    @ObservedObject var netflixObjectViewModel: NetflixObjectDetailsViewModel
    
    init(netflixObject: NetflixObject){
        self.netflixObjectViewModel = NetflixObjectDetailsViewModel(netflixObject: netflixObject)
    }
    
    var netflixObject: NetflixObject {
        return netflixObjectViewModel.netflixObject
    }
    
    
    var body: some View {
        createDetailsView()
    }
    
    
    
    func createDetailsView() -> some  View {
        if netflixObject.type == .tv {
            if let tvShow = netflixObject.tvShow {
                return AnyView(DetailsView_TV(tvShow: tvShow))
            }
        } else {
            if let movieId = netflixObject.movie?.id {
                return AnyView(DetailsView_Movie(movieId: movieId))
            }
        }
        return AnyView(EmptyView())
    }
    
}
