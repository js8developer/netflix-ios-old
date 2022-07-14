//
//  Section_Movies.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import SwiftUI


struct Section_Movies: View {
    
    @ObservedObject var sectionViewModel_Movies: SectionViewModel_Movies
    var title: String

    init(sectionViewModel_Movies: SectionViewModel_Movies, title: String = "") {
        self.sectionViewModel_Movies = sectionViewModel_Movies
        self.title = title
    }
    
    let spacing: CGFloat = 16
    
    
    var body: some View {
        Group {
            if sectionViewModel_Movies.state == .loading { shimmerLoadingView }
            else {
                if !sectionViewModel_Movies.movies.isEmpty { moviesSection }
                else { Rectangle().fill(Color.clear) }
            }
        }
        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
    }
    
    
    var moviesSection: some View {
        VStack(alignment: .leading, spacing: spacing) {
            titleHeader
            moviesScrollView
        }
    }

    
    
    var titleHeader: some View {
        Text(title)
            .font(.system(size: 24, weight: .bold))
    }
    
    var moviesScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(sectionViewModel_Movies.movies) { (movie) in
                    MovieCell(movie: movie)
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
    }
    
    
}

