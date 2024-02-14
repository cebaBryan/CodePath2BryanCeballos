import UIKit

class MoviePosterController: UICollectionViewController {
    
    var movies: [Movie] = []
    var oldWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }
    
    func loadMovies() {
        NetworkManager.shared.fetchMovies { [weak self] (fetchedMovies, error) in
            DispatchQueue.main.async {
                if let movies = fetchedMovies {
                    self?.movies = movies
                    self?.collectionView.reloadData()
                } else if let error = error {
                    print("Error fetching movies: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as? MoviePosterCell else {
            fatalError("The dequeued cell is not an instance of MoviePosterCell.")
        }
        
        let movie = movies[indexPath.item]
        cell.configure(with: movie.posterPath)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collxectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.item]
        performSegue(withIdentifier: "showMovieDetail", sender: movie)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail",
           let destinationVC = segue.destination as? MovieDetailViewController,
           let index = collectionView.indexPathsForSelectedItems?.first {
            let movie = movies[index.item]
            destinationVC.movie = movie
        }
    }
}
