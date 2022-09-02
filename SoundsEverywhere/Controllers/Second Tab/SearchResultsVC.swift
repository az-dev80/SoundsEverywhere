//
//  SearchResultsVC.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 11.11.21.
//

import UIKit
import Gradients

class SearchResultsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .semibold)]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor:UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let gradientLayer = Gradients.solidStone.layer
        gradientLayer.frame = self.view.bounds
       
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
}

extension SearchResultsVC: UIScrollViewDelegate {
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
