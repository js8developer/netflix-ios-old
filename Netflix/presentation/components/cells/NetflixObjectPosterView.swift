//
//  NetflixObjectPosterView.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/13/22.
//

import SwiftUI


struct NetflixObjectPosterView_Previews: PreviewProvider {
    static var previews: some View {
        NetflixObjectPosterView(posterUrl: frozen2Movie.posterUrl, titleString: frozen2Movie.title)
    }
}


struct NetflixObjectPosterView: View {
    
    var posterUrl: URL?
    var titleString: String
    
    
    var moviePoster: some View {
        AsyncImage(
            url: posterUrl!,
            configuration: { AnyView($0.resizable()) },
            defaultView: { AnyView(defaultTextView)}
        )
    }
    
    
    var defaultTextView: some View {
        Text(titleString)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
    }
    
    

    var body: some View {
        Group {
            if posterUrl != nil { moviePoster }
            else { defaultTextView }
        }
        .frame(width: 150, height: 245)
        .background(Color.darkGray)
        .cornerRadius(8.0)
    }
    
}

