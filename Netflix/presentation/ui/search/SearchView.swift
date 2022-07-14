//
//  SearchView.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/13/22.
//

import SwiftUI
import UIKit


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}



struct SearchView: View {
    @ObservedObject var searchManager = SearchManager()


    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color(uiColor: .systemBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: 16) {
                    SearchBar(text: $searchManager.searchText)
                    moviesAndTVTextView
                    searchView
                }
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    

    var loadingView: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(0..<10, id: \.self) { _ in
                    HStack(alignment: .center, spacing: 10) {
                        ForEach(0..<3, id: \.self) { _ in
                            self.loadingCell()
                        }
                    }.frame(maxWidth: .infinity)
                }
            }
        }
        .gesture(DragGesture()
                    .onChanged { _ in
            
        })
    }

    func loadingCell() -> some View {
        return VStack(alignment: .leading) {
            ShimmerView()
                .frame(width: 100, height: 180)
                .cornerRadius(8.0)
        }
    }
    
    
    var moviesAndTVTextView: some View {
        HStack {
            Text("Movies & TV")
                .font(.system(size: 18, weight: .bold))
            
            Spacer()
        }
        .padding()
        .opacity(searchManager.items.count > 0 ? 1 : 0)
    }
    
    
    
    var searchView: some View {
        return searchManager.items.count > 0 ? AnyView(searchResultsList) : AnyView(EmptySearchView())
        
    }
    
    
    var searchResultsList: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(0..<self.searchManager.items.count, id: \.self) { index in
                    HStack(alignment: .center, spacing: 10) {
                        ForEach(self.searchManager.items[index], id: \.id) { item in
                            self.cellFor(item)
                        }
                    }.frame(maxWidth: .infinity)
                }
            }
        }
        .gesture(DragGesture().onChanged { _ in
            
        })
    }
    

    func cellFor(_ item: SearchViewModel_Item) -> some View {
        return Group {
            if item.type == SearchViewModel_Item.SearchItemType.tvShow {
                tvShowCellFor(item)
            } else {
                movieCellFor(item)
            }
        }
    }

    func tvShowCellFor(_ item: SearchViewModel_Item) -> some View {
        return NavigationLink(destination: DetailsView_TV(tvShow: item.tvShow!)) {
                cellUiFor(item)
        }
    }

    func movieCellFor(_ item: SearchViewModel_Item) -> some View {
         return NavigationLink(destination: DetailsView_Movie(movieId: item.sourceId)) { cellUiFor(item) }
    }

    func cellUiFor(_ item: SearchViewModel_Item) -> some View {
        
        let cellWidth: CGFloat = (fullWidth / 3) - (8 * 2)// 100
        
        return VStack(alignment: .leading) {
            Group {
                if item.posterUrl != nil {
                    AsyncImage(url: item.posterUrl!,
                               configuration: {AnyView($0.resizable())},
                               defaultView: {
                                AnyView(
                                    Text(item.title)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                )
                        }).clipped()
                } else {
                    Text(item.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(width: cellWidth, height: 160)
            .background(Color.darkGray)
            .cornerRadius(8.0)
            
            Text(item.title)
                .font(.system(size: 10, weight: .bold))
                .lineLimit(1)
                .foregroundColor(.white)
                .frame(width: cellWidth)
        }
    }
}






/*

struct SearchView: View {
    @ObservedObject var searchViewModel = SearchViewModel()


    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color(uiColor: .systemBackground)
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack(alignment: .center, spacing: 16) {
                    SearchBar(text: $searchViewModel.searchText)
                    moviesAndTVTextView
                    searchResultsList
                }
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    

    var loadingView: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(0..<10, id: \.self) { _ in
                    HStack(alignment: .center, spacing: 10) {
                        ForEach(0..<3, id: \.self) { _ in
                            self.loadingCell()
                        }
                    }.frame(maxWidth: .infinity)
                }
            }
        }
        .gesture(DragGesture()
                    .onChanged { _ in
            
        })
    }

    func loadingCell() -> some View {
        return VStack(alignment: .leading) {
            ShimmerView()
            .frame(width: 100, height: 180)
            .cornerRadius(8.0)
        }
    }
    
    
    var moviesAndTVTextView: some View {
        HStack {
            Text("Movies & TV")
                .font(.system(size: 18, weight: .bold))
            
            Spacer()
        }
        .padding()
        .opacity(searchViewModel.items.count > 0 ? 1 : 0)
    }
    
    
    var searchResultsList: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(0..<searchViewModel.items.count, id: \.self) { index in
                    HStack(alignment: .center, spacing: 10) {
                        ForEach(self.searchViewModel.items[index], id: \.id) { item in
                            self.cellFor(item)
                        }
                    }.frame(maxWidth: .infinity)
                }
            }
        }
        .gesture(DragGesture().onChanged { _ in
            
        })
    }
    

    func cellFor(_ item: SearchItemViewModel) -> some View {
        return Group {
            if item.type == SearchItemViewModel.SearchItemType.tvShow {
                tvShowCellFor(item)
            } else {
                movieCellFor(item)
            }
        }
    }

    func tvShowCellFor(_ item: SearchItemViewModel) -> some View {
        
        if let tvShow = item.tvShow {
            return NavigationLink(destination: TVShowDetails(tvShow: tvShow)) {
                cellUiFor(item)
            }
        }
        
        return NavigationLink(destination: Text("Bonjour")) {
            cellUiFor(item)
        }
    }

    func movieCellFor(_ item: SearchItemViewModel) -> some View {
         return NavigationLink(destination: MovieDetails(movieId: item.sourceId)) { cellUiFor(item) }
    }

    func cellUiFor(_ item: SearchItemViewModel) -> some View {
        
        let cellWidth: CGFloat = (fullWidth / 3) - (8 * 2)// 100
        
        return VStack(alignment: .leading) {
            Group {
                if item.posterUrl != nil {
                    AsyncImage(url: item.posterUrl!,
                               configuration: {AnyView($0.resizable())},
                               defaultView: {
                                AnyView(
                                    Text(item.title)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                )
                        }).clipped()
                } else {
                    Text(item.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(width: cellWidth, height: 160)
            .background(Color.lightGray)
            .cornerRadius(8.0)
            
            Text(item.title)
                .font(.system(size: 10, weight: .bold))
                .lineLimit(1)
                .foregroundColor(.white)
                .frame(width: cellWidth)
        }
    }
}

*/
