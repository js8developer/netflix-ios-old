//
//  Section_TV.swift
//  Netflix
//
//  Created by Jason Schneider on 7/14/22.
//

import SwiftUI



struct Section_TV: View {
    
    @ObservedObject var sectionViewModel_TV: SectionViewModel_TV
    var title: String

    
    init(sectionViewModel_TV: SectionViewModel_TV, title: String = "") {
        self.sectionViewModel_TV = sectionViewModel_TV
        self.title = title
    }
    
    
    var body: some View {
        Group {
            if sectionViewModel_TV.state == .loading { shimmerLoadingView }
            else {
                if !sectionViewModel_TV.tvShows.isEmpty { section_tv }
                else { Rectangle().fill(Color.clear) }
            }
        }
        .transition(
            AnyTransition.opacity
                .animation(.easeInOut(duration: 0.5))
        )
    }
    
    
    var section_tv: some View {
        VStack(alignment: .leading, spacing: 16) {
            titleHeader
            tvShowsScrollView
        }
    }


    
    var titleHeader: some View {
        Text(title)
            .font(.system(size: 24, weight: .bold))
            .padding(.leading, 16)
    }
    
    
    var tvShowsScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(sectionViewModel_TV.tvShows) { tvShow in
                    TVShowCell(tvShow: tvShow)
                }
            }
            .frame(height: 245)
           
        }
    }
    
    
    var shimmerLoadingView: some View {
        VStack(alignment: .leading, spacing: 10) {
            ShimmerView()
                .frame(width: fullWidth * 0.55, height: 32)
            ShimmerView()
                .frame(height: 245)
        }
        .padding(.horizontal, 10)
    }
  
}
