//
//  FavoritesVC.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 1.11.21.
//

import UIKit
import Gradients

class SearchVC: UIViewController, UISearchResultsUpdating {
   
    let model = SearchCategoriesModel()
    var gradientLayer: CALayer!
    
    let searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultsVC())
        vc.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: [.foregroundColor: UIColor.white])
        //set up text color when entering
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [.foregroundColor: UIColor.white]
        //set up color for Cancel button
        vc.searchBar.tintColor = .white
        //set up search icon color
        vc.searchBar.searchTextField.leftView?.tintColor = .white
        //styling text field in search bar
        vc.searchBar.searchTextField.backgroundColor = .systemGray
        vc.searchBar.searchTextField.alpha = 0.25
        vc.searchBar.searchBarStyle = .minimal
        
        vc.definesPresentationContext = true
        return vc
    }()
    
    let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(180)),
                subitem: item,
                count: 2)
            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            
            return NSCollectionLayoutSection(group: group)
        })
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        gradientLayer = Gradients.solidStone.layer
        view.layer.insertSublayer(gradientLayer, at:0)
        //view.backgroundColor = .systemBackground
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .semibold)]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor:UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        view.backgroundColor = .clear
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        view.addSubview(collectionView)
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        gradientLayer.frame = self.view.bounds
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //empty
    }
    
}

extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.searchCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: model.searchCategories[indexPath.row].capitalized)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = model.searchCategories[indexPath.row]
        let vc = CategoryVC(category: category, index: 0)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // guard let resultsController = searchController.searchResultsController as? SearchResultsVC,
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty
        else { return }
        
        let vc = CategoryVC(category: query, index: 1)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
        
        print(query)
        
    }
}
extension SearchVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let gradientLayer = Gradients.solidStone.layer
        if let bounds = navigationController?.navigationBar.bounds{
            gradientLayer.frame = bounds
        }
        navigationController?.navigationBar.setBackgroundImage(self.image(fromLayer: gradientLayer), for: .default)
    }
    
    func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)

        layer.render(in: UIGraphicsGetCurrentContext()!)

        let outputImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return outputImage!
    }
}
