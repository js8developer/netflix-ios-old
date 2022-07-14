//
//  NetflixObject.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/13/22.
//

import Foundation
import SwiftUI


enum SelectedType {
    case tv, movie, category
}

struct NetflixObject {
    var id = UUID()

    var type: SelectedType
    var tvShow: TVShow? = nil
    var movie: Movie? = nil
}




//protocol Netflixable {
//    var id = UUID()
//    
//    var type: SelectedType
//    var tvShow: TVShow? = nil
//    var movie: Movie? = nil
//    
//    
//    var id: String { get }
//    var title: String { get }
//    
//}
