//
//  APIRequest.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import Foundation

class APIRequest<E: Decodable>: Encodable {
    let path: String
    let parameters: [String: String]?
    init(path: String, parameters: [String: String]? = nil) {
        self.path = path
        self.parameters = parameters
    }
}
