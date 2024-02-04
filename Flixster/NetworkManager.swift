// NetworkManager.swift

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func fetchMovies(completion: @escaping ([Movie]?, Error?) -> Void) {
        guard let url = APIService.fetchMoviesURL() else {
            completion(nil, NSError(domain: "NetworkManagerError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "NetworkManagerError", code: 1002, userInfo: [NSLocalizedDescriptionKey: "No data"]))
                return
            }

            do {
                let decoder = JSONDecoder()
                let moviesResponse = try decoder.decode(MovieResponse.self, from: data)
                            completion(moviesResponse.results, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}

// Define the response structure based on the JSON returned by the API
struct MovieResponse: Codable {
    let results: [Movie]
}

