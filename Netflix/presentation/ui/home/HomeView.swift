//
//  HomeView.swift
//  Netflix
//
//  Created by Jason Schneider on 7/14/22.
//

import SwiftUI
import UIKit

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct HomeView: View {
    @State public var selectedType: SelectedType = .tv

    var body: some View {
        NavigationView {
            ZStack {
                Color(uiColor: UIColor.systemBackground)
                    .edgesIgnoringSafeArea(.all)

                mainView
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        }
    
    }
    
    // // // //
    
    var mainView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center) {
                header
                
                tabButtons
                    .padding(.top, 36)
                    .padding(.bottom, 36)
                
                self.containedView()
            }
            .padding()
        }
    }
    
   
    
    
    var header: some View {
        HStack {
            Image("netflix")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
                .foregroundColor(.red)
            
            Spacer()
            
            Image(systemName: "person")
                .frame(width: 40, height: 40)
                .background(Color.niceGray)
                .foregroundColor(.primary)
                .clipShape(Circle())
        }
    }
    
    var tabButtons: some View {
        HStack {
            HomeTabItem(tab: Tab(title: "TV Shows", type: .tv), selectedType: $selectedType)
            HomeTabItem(tab: Tab(title: "Movies", type: .movie), selectedType: $selectedType)
            HomeTabItem(tab: Tab(title: "Categories", type: .category), selectedType: $selectedType)
        }
    }
    
    func containedView() -> AnyView {
        if selectedType == .tv {
            return AnyView(HomeView_TV())
        }
        else if selectedType == .movie {
            return AnyView(HomeView_Movies())
        }
        else {
            return AnyView(HomeView_Categories())
        }
    }
    
    
}





struct Tab: Identifiable {
    var id = UUID()
    
    var title: String
    var type: SelectedType
}


struct HomeTabItem: View {
    
    var tab: Tab
    @Binding var selectedType: SelectedType
    
    var body: some View {
        VStack {
            Button(action: {
                selectedType = tab.type
            }){
                Text(tab.title)
                    .font(.system(size: 18, weight: .bold))
                    .accentColor(selectedType == tab.type ? .red : .gray)
            }
            .padding(.horizontal)
            
            Rectangle()
                .fill(selectedType == tab.type ? .red : .clear)
                .frame(width: 50, height: 4)
                .cornerRadius(2)
        }
        
    }
}
