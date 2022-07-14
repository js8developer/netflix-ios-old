//
//  TVShowCell.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import SwiftUI

struct TVShowCell: View {
    
    var tvShow: TVShow

    var body: some View {
        NavigationLink(destination: NetflixObjectDetailsView(netflixObject: NetflixObject(type: .tv, tvShow: tvShow))) {
            
            Group {
                NetflixObjectPosterView(posterUrl: tvShow.posterUrl, titleString: tvShow.title)
            }
        }
    }
}


