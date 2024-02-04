//
//  APIService.swift
//  Flixster
//
//  Created by Bryan Ceballos on 2/4/24.
//

// APIService.swift

import Foundation

struct APIService {
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiKey = "1acbb918ab951357aaace9ad09c592d6"

    static func fetchMoviesURL() -> URL? {
        return URL(string: "\(baseURL)/movie/popular?api_key=\(apiKey)")
    }
    
    // You can add more functions to construct different API endpoint URLs here
}
