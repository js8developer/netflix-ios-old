//
//  HomeView_Categories.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import Foundation
import SwiftUI

struct HomeView_Categories_Previews: PreviewProvider {
    static var previews: some View {
        HomeView_Categories()
    }
}


struct HomeView_Categories: View {
   
    @State var categories: [String] = [
        "Home",
        "My List",
        "Available for Download",
        "Action",
        "Anime",
        "Children & Family",
        "Comedies",
        "Crime",
        "Critically Acclaimed",
        "Documentaries",
        "Dramas",
        "Fantasy",
        "Horror",
        "..."
    ]
    

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading, spacing: 36) {
                
                ForEach(categories, id: \.self){ (category) in
                    HStack {
                        Text(category)
                            .foregroundColor(.primary)
                            .font(.system(size: 18, weight: .semibold))
                        Spacer()
                    }
                    
                }
                
            }
        }
        
    }
    
    
}


