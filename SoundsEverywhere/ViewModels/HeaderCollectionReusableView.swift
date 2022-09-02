//
//  HeaderCollectionReusableView.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 12.11.21.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "HeaderCollectionReusableView"
    
    let bottomBorder = CALayer()
   
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        
        bottomBorder.backgroundColor = UIColor.white.cgColor
        layer.addSublayer(bottomBorder)
        
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 15, y: 0, width: frame.width - 30, height: frame.height)
        
        let thickness: CGFloat = 2.0
        let widthBorder = label.intrinsicContentSize.width - 30
        let padding = (frame.width - widthBorder)/2
        bottomBorder.frame = CGRect(x:padding, y: frame.size.height - thickness - 10, width: widthBorder, height:thickness)
    }
    
    func configure(with title: String) {
        label.text = title
    }
}
