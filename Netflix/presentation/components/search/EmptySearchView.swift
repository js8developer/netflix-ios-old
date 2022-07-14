//
//  EmptySearchView.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/13/22.
//

import SwiftUI


struct EmptySearchView_Previews: PreviewProvider {
    static var previews: some View {
        EmptySearchView()
    }
}


struct EmptySearchView: View {
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 60))
                
                Text("Search for your favorite movies and shows above")
                    .padding()
            }
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            
            Spacer()
        }
        .padding()
    }
}
