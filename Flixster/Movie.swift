//
//  Movie.swift
//  Flixster
//
//  Created by Bryan Ceballos on 2/4/24.
// Movie.swift

import Foundation

struct Movie: Codable {
    let title: String
    let posterPath: String
    let overview: String
    let voteCount: Int
    let voteAverage: Double
    let popularity: Double

    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"  // Assuming the JSON key is "poster_path"
        case overview
        case voteCount = "vote_count"    // Assuming the JSON key is "vote_count"
        case voteAverage = "vote_average"// Assuming the JSON key is "vote_average"
        case popularity
    }
}


