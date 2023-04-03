//
//  SearchVC.swift
//  MoviesTMDB
//
//  Created by Oliwia Procyk on 23/02/2023.
//

import UIKit
import Kingfisher

final class HomeVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = HomeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupActivityIndicator()
        viewModel.delegate = self
        viewModel.getMovie()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.text = ""
    }
    
    private func setup() {
        title = "Movies"
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
    }

}

extension HomeVC: HomeDelegate {
    func startActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func success() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func error(error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MovieCell
        
        let movie = viewModel.movies[indexPath.row]
        
        cell.titleMovieLable.text = movie.title
        cell.overviewLabel.text = movie.overview
        
        if let path = movie.posterPath {
            let url = URL(string: "http://image.tmdb.org/t/p/w500\(path)")
            cell.movieImageView.kf.setImage(with: url)
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.storyboardIdDVC) as? DetailsVC
        
        guard let movieID = viewModel.movies[indexPath.row].id else { return }
        
        vc?.getID(id: movieID)
        print(movieID)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - (2 * height) {
            self.viewModel.getMovie()
        }
    }
}
extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            self.viewModel.searchMovie(query: searchText)
            if !viewModel.movies.isEmpty {
                self.scrollToFirstRow()
            }
        } else {
            self.viewModel.getMovie()
        }
    }
}

