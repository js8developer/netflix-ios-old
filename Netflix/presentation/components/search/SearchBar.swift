//
//  SearchBar.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import SwiftUI

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Search"))
    }
}


struct SearchBar: View {
    @Binding var text: String

    var searchTextField: some View {
        TextField("Search", text: $text)
            .foregroundColor(Color.gray)
            .frame(height: 50)
    }
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.gray)

                searchTextField

                xButtonView(text: $text)
                
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .background(Color.niceGray)
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
    }
}



struct xButtonView: View {
    
    @Binding var text: String
    
    var body: some View {
        if !text.isEmpty {
            Button(action : {
                self.text = ""
            }){
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(Color.lightGray)
            }
        } else {
            EmptyView()
        }
    }
    
}
