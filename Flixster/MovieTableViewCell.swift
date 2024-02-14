// 
//  MovieTableViewCell.swift
//  Flixster
//
//  Created by Bryan Ceballos on 2/4/24.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!   
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    
    func configure(with movie: Movie) {
        movieTitleLabel.text = movie.title
        movieOverviewLabel.text = movie.overview
        moviePosterImageView.image = UIImage(named: "placeholder")
        
        if movie.posterPath.isEmpty {
            moviePosterImageView.image = UIImage(named: "placeholder")
            return
        }

        let posterBaseURL = "https://image.tmdb.org/t/p/w500"
        let posterURLString = "\(posterBaseURL)\(movie.posterPath)"
        guard let posterURL = URL(string: posterURLString) else {
            print("Invalid poster path: \(movie.posterPath)")
            return
        }
        
        URLSession.shared.dataTask(with: posterURL) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                if self?.movieTitleLabel.text == movie.title {
                    self?.moviePosterImageView.image = image
                }
            }
        }.resume()
    }
}

