//
//  TVSeason.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//
import Foundation
struct TVSeason: Identifiable, Decodable, Encodable {
    let id: Int
    let name: String
    let overview: String?
    let seasonNumber: Int
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case seasonNumber = "season_number"
        case posterPath = "poster_path"
    }
}
