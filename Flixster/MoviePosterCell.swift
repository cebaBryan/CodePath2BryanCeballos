import UIKit

class MoviePosterCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            posterImageView.contentMode = .scaleAspectFit
            posterImageView.clipsToBounds = true
    }
    
    func configure(with posterPath: String) {
        let posterBaseURL = "https://image.tmdb.org/t/p/w500"
        let posterURLString = "\(posterBaseURL)\(posterPath)"
        guard let posterURL = URL(string: posterURLString) else {
            print("Invalid poster path: \(posterPath)")
            return
        }
        
        // Image loading with URLSession or a library like SDWebImage
        URLSession.shared.dataTask(with: posterURL) { [weak self] data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                }
            } else if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                // Optionally, set a placeholder image here
            }
        }.resume()
    }
}

