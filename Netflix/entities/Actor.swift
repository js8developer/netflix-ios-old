//
//  Actor.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import Foundation


struct Actor: Decodable, Identifiable {
    let id: Int
    let name: String
    let character: String
    let order: Int
    let profilePath: String?

    var profileUrl: URL? {
        guard let profilePath = profilePath else {
            return nil
        }
        let url = URL(string: "\(APIClient.baseImageStringUrl)\(profilePath)")
        return url
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case order
        case profilePath = "profile_path"
    }
}
