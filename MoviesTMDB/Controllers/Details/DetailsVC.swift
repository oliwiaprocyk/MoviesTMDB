//
//  DetailsVC.swift
//  MoviesTMDB
//
//  Created by Oliwia Procyk on 23/02/2023.
//

import UIKit
import Kingfisher

final class DetailsVC: BaseViewController {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    private var movieID: Int?
    private var viewModel = DetailsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        viewModel.delegate = self
        if let movieID = movieID {
            viewModel.getDetail(movieID: movieID)
        }
        setupActivityIndicator()
    }
    
    func getID(id: Int) {
        movieID = id
    }
}

extension DetailsVC: DetailDelegate {
    func startActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func error(error: String) {
        let alert = UIAlertController(title: "Alert", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setup(movie: DetailsModel) {
        DispatchQueue.main.async {
            self.titleMovieLabel.text = movie.title
            self.overviewLabel.text = movie.overview
            if let path = movie.posterPath {
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
                self.movieImageView.kf.setImage(with: url)
            }
            self.activityIndicator.stopAnimating()
        }
    }
}
