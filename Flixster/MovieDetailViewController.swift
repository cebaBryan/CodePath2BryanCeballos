// MovieDetailViewController.swift

import UIKit

class MovieDetailViewController: UIViewController {
    // Outlets
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    

    // The movie property to be set before the segue
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieDetails()
    }

    func loadMovieDetails() {
        guard let movie = movie else { return }

        movieTitleLabel?.text = movie.title
        movieOverviewLabel?.text = movie.overview
        voteCountLabel?.text = "Votes: \(movie.voteCount)"
        voteAverageLabel?.text = "Average: \(movie.voteAverage)"
        popularityLabel?.text = "Popularity: \(movie.popularity)"

        // Load the movie poster image
        let posterBaseURL = "https://image.tmdb.org/t/p/w500"
        let posterURLString = "\(posterBaseURL)\(movie.posterPath)"
        if let posterURL = URL(string: posterURLString) {
            URLSession.shared.dataTask(with: posterURL) { [weak self] data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.moviePosterImageView.image = image
                    }
                } else if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    // Optionally, you could set a placeholder image here if the image fails to load
                }
            }.resume()
        } else {
            moviePosterImageView.image = UIImage(named: "placeholder")
        }
    }

}

