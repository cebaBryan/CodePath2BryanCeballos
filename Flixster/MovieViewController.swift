//
//  MoviesViewController.swift
//  Flixster
//
//  Created by Bryan Ceballos on 2/4/24.
//

import UIKit

class MovieViewController: UITableViewController {
    
    var movies: [Movie] = []
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        fetchMovies()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    func fetchMovies() {
        activityIndicator.startAnimating()
        NetworkManager.shared.fetchMovies { [weak self] (movies, error) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                if let movies = movies {
                    self?.movies = movies
                    self?.tableView.reloadData()
                } else if let error = error {
                    self?.showErrorAlert(message: error.localizedDescription)
                }
            }
        }
    }

    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else {
            fatalError("Could not dequeue MovieCell")
        }
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showMovieDetail", sender: indexPath)
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail",
           let destinationVC = segue.destination as? MovieDetailViewController,
           let selectedIndexPath = tableView.indexPathForSelectedRow {
            destinationVC.movie = movies[selectedIndexPath.row]
        }
    }
}
