//
//  CategoryVC.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 8.11.21.
//

import UIKit
import Gradients

class CategoryVC: UIViewController {

    let category: String
    let index:Int
    
    private var categorySounds = [Resulter]()
    //private var sounds: [LastSoundsCellViewModel] = []
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(70)),
                subitem: item,
                count: 1)
            
            return NSCollectionLayoutSection(group: group)
        })
    )
    
    init(category: String, index: Int){
        self.category = category.capitalized
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = category
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .semibold)]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor:UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        view.backgroundColor = .clear
        
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LastSoundsCollectionViewCell.self, forCellWithReuseIdentifier: LastSoundsCollectionViewCell.identifier)
        if index == 0 {
            APICaller.shared.getCategorySounds(category: category) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let model):
                        self?.categorySounds = model.results
                        self?.collectionView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    //                self?.sounds.append(contentsOf: self?.categorySounds.compactMap({
                    //                    return LastSoundsCellViewModel(name: $0.name, userName: $0.username, image: URL (string: $0.images.waveformBWM))
                    //                }) ?? [])
                }
            }
        }
        else {
            APICaller.shared.searchSounds(query: category) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let model):
                        self?.categorySounds = model.results
                        self?.collectionView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.frame = view.bounds
        
        let gradientLayer = Gradients.solidStone.layer
        gradientLayer.frame = self.view.bounds
       
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension CategoryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categorySounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LastSoundsCollectionViewCell.identifier, for: indexPath) as? LastSoundsCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: LastSoundsCellViewModel(
                        name: categorySounds[indexPath.row].name,
                        userName: categorySounds[indexPath.row].username,
                        image: URL(string: categorySounds[indexPath.row].images.waveformBWM))
        )
        cell.isOpaque = false
        cell.layer.opacity = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let sound = categorySounds[indexPath.row]
        //        let vc = SoundVC(sound: sound)
        //        vc.title = recent.name
        //        vc.navigationItem.largeTitleDisplayMode = .never
        //        navigationController?.pushViewController(vc, animated: true)
        PlayPresenter.shared.startPlaying(from: self, sound: sound)
        //PlayPresenter.shared.startPlaying(from: self, sounds: categorySounds, index: indexPath.row)
        //PlayPresenter.shared.startPlaying(from: self, sounds: categorySounds, index: indexPath.row)
        //        guard let url = URL(string: categorySounds[indexPath.row].url) else { return }
        //        let vc = SFSafariViewController(url: url)
//        self.present(vc, animated: true, completion: nil)
    }
    
    
}
