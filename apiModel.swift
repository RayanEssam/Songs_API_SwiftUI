//
//  apiModel.swift
//  Songs_API
//
//  Created by Rayan Taj on 16/11/2021.
//

import Foundation


struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
    var artistName : String
    var artworkUrl60 : URL
}
