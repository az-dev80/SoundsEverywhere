//
//  HomeVC.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 3.11.21.
//

import UIKit
import Gradients

enum SectionType {
    case topRated(viewModels:[TopRatedCellViewModel])
    case lastSounds(viewModels:[LastSoundsCellViewModel])
    
    var title: String {
        switch self {
        case .topRated:
            return "Top rated sounds"
        case .lastSounds:
            return "Recent sounds"
        }
    }
    
}

class HomeVC: UIViewController {
    private var bestRated: [Resulter] = []
    private var recentSounds: [Resulter] = []
    private var gradientLayer: CALayer!
    
    var api: APICaller = .shared
    
    init(api: APICaller){
        self.api = api
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return HomeVC.createSectionLayout(section: sectionIndex)
        }
    )
    
    private let spinner: UIActivityIndicatorView = {
       let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var sections = [SectionType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        gradientLayer = Gradients.solidStone.layer
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .semibold)]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor:UIColor.white]
       // navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        view.backgroundColor = .clear
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(goToProfile))
        
        configureCollectionView()
        view.addSubview(spinner)
        getData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        gradientLayer.frame = view.bounds
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(TopRatedCollectionViewCell.self, forCellWithReuseIdentifier: TopRatedCollectionViewCell.identifier)
        collectionView.register(LastSoundsCollectionViewCell.self, forCellWithReuseIdentifier: LastSoundsCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
    }
    
    private static func createSectionLayout(section:Int) -> NSCollectionLayoutSection {
        let suppVc = [NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(70)),
            elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
        ]
        
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(390)),
                subitem: item,
                count: 3)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(390)),
                subitem: verticalGroup,
                count: 1)
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = suppVc
            return section
        case 1:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10)
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(60)),
                subitem: item,
                count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = suppVc
            return section
        default:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0))
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(390)),
                subitem: item,
                count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = suppVc
            return section
        }
    }
    
//    @objc func goToProfile() {
//        let vc = ProfileVC()
//        vc.title = "Profile"
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
    private func getData() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        
        var toppRated: TopRatedSoundsModel?
        var lasttSounds: LastSoundsModel?
        
        //TopRated
        api.getTopRatedSounds { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                toppRated = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        api.getLastSounds { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                lasttSounds = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        group.notify(queue: .main) {
            guard let bestRated = toppRated?.results,
                  let recentSounds = lasttSounds?.results else {
                return
            }
            self.configureModels(bestRated: bestRated, recentSounds: recentSounds)
        }
        
    }
    
    private func configureModels(bestRated: [Resulter], recentSounds: [Resulter]) {
        self.bestRated = bestRated
        self.recentSounds = recentSounds
        
        sections.append(.topRated(viewModels: bestRated.compactMap({
            return TopRatedCellViewModel(name: $0.name, userName: $0.username, numOfDownloads: $0.numDownloads, rating: $0.avgRating, image: URL(string: $0.images.waveformBWM))
        })))
        sections.append(.lastSounds(viewModels: recentSounds.compactMap({
            return LastSoundsCellViewModel(name: $0.name, userName: $0.username, image: URL (string: $0.images.waveformBWM))
        })))
        collectionView.reloadData()
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
        case .topRated(let viewModels):
            return viewModels.count
        case .lastSounds(let viewModels):
            return viewModels.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        switch type {
        case .topRated(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCollectionViewCell.identifier, for: indexPath) as? TopRatedCollectionViewCell else { return UICollectionViewCell() }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            //cell.backgroundColor = .red
           
            //cell.backgroundView?.insertSubview(aview, at: 0)
            
            return cell
        case .lastSounds(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LastSoundsCollectionViewCell.identifier, for: indexPath) as? LastSoundsCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let section = sections[indexPath.section]
        switch section {
        case .topRated:
            let sound = bestRated[indexPath.row]
            PlayPresenter.shared.startPlaying(from: self, sound: sound)
           // let vc = SoundVC(sound: top)
           // vc.title = top.name
//            vc.navigationItem.largeTitleDisplayMode = .never
//            navigationController?.pushViewController(vc, animated: true)
        case .lastSounds:
//            let recent = recentSounds[indexPath.row]
//            let vc = SoundVC(sound: recent)
//            //vc.title = recent.name
//            vc.navigationItem.largeTitleDisplayMode = .never
//            navigationController?.pushViewController(vc, animated: true)
            let sound = recentSounds[indexPath.row]
            PlayPresenter.shared.startPlaying(from: self, sound: sound)
            //PlayPresenter.shared.startPlaying(from: self, sounds: recentSounds, index: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let section = indexPath.section
        let title = sections[section].title
        header.configure(with: title)
        return header
    }
    
}
extension HomeVC: UIScrollViewDelegate {
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
