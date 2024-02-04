// MovieTableViewCell.swift

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieOverviewLabel: UILabel!

    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    
    func configure(with movie: Movie) {
        movieTitleLabel.text = movie.title
        movieOverviewLabel.text = movie.overview
        moviePosterImageView.image = UIImage(named: "placeholder") // Placeholder image
        
        // Check if the poster path is empty
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
        
        // Image loading with URLSession
        URLSession.shared.dataTask(with: posterURL) { [weak self] data, response, error in
            // Handle error or data being nil
            guard let data = data, let image = UIImage(data: data) else {
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                // Ensure the cell for which this image was loaded is still the cell to display this image
                if self?.movieTitleLabel.text == movie.title {
                    self?.moviePosterImageView.image = image
                }
            }
        }.resume()
    }
}

