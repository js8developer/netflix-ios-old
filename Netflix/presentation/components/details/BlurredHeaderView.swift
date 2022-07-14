//
//  BlurredHeaderView.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/13/22.
//

import SwiftUI


struct BlurredHeaderView: View {
    
    @ObservedObject var netflixObjectDetailsViewModel: NetflixObjectDetailsViewModel
    
    var netflixObject: NetflixObject {
        return netflixObjectDetailsViewModel.netflixObject
    }
    
    var title: String {
        return netflixObjectDetailsViewModel.getTitle()
    }
    
    var posterUrl: URL? {
        return netflixObjectDetailsViewModel.getPosterURL()
    }
    
    init(netflixObjectDetailsViewModel: NetflixObjectDetailsViewModel){
        self.netflixObjectDetailsViewModel = netflixObjectDetailsViewModel
    }
    
  
    
    
    var body: some View {
        header
    }
    
    
    
    
    var header: some View {
        ZStack {
            BlurredPosterView(posterUrl: posterUrl)
            makeHeaderForeground()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 500, alignment: .topLeading)
        .padding(.bottom, 10)
        .clipped()
    }
    

    
    func makeHeaderForeground() -> AnyView {
        
        return AnyView(
            VStack(alignment: .center, spacing: 20) {
            
                NetflixObjectPosterView(posterUrl: posterUrl, titleString: title)
                    .padding(.top, 50)
            
                Text(title)
                    .font(.system(size: 32, weight: .bold)).minimumScaleFactor(0.5)
                
                Text(netflixObjectDetailsViewModel.overviewString())
                    .font(.system(size: 15, weight: .regular))
                    .lineLimit(5)
                    .multilineTextAlignment(.center)
                
                HStack(alignment: .center, spacing: 60) {
                    ScoreView(voteAverage: netflixObjectDetailsViewModel.voteAverage())
                    
                    Text(netflixObjectDetailsViewModel.releaseDateString()).fontWeight(.semibold)
                }
                
            }
            .padding([.leading, .trailing, .bottom], 16)
        )
        
    }
    
    
    var makeDefaultView: some View {
        Rectangle()
            .fill(Color.black.opacity(0.45))
    }
    
}




struct BlurredPosterView: View {
    
    var posterUrl: URL?
  
    var body: some View {
        makeBlurredBackground(posterUrl: posterUrl)
    }
    

    func makeBlurredBackground(posterUrl: URL?) -> AnyView {
        guard let posterUrl = posterUrl else {
            return AnyView(makeDefaultView)
        }

        let asyncImage =  AsyncImage(url: posterUrl,
                   configuration: {
                    AnyView(
                        AnyView($0.resizable())
                            .blur(radius: 25, opaque: true)
                    )
        },
                   defaultView: { AnyView(makeDefaultView) }
        )
        
        return AnyView(asyncImage)
    }
    

    var makeDefaultView: some View {
        Rectangle()
            .fill(Color.black.opacity(0.45))
    }
    
}

