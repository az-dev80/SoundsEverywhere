//
//  SearchCollectionViewCell.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 8.11.21.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchCollectionViewCell"
    
    private let image: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        img.tintColor = .white
        img.contentMode = .scaleAspectFit
        
        //img.clipsToBounds = true
        return img
    }()
    
    private let nameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = .systemFont(ofSize: 22, weight: .semibold)
        lb.adjustsFontSizeToFitWidth = true
        
        return lb
    }()
    
    private let colors: [UIColor] = [
        .systemPink,
        .systemPurple,
        .systemBlue,
        .systemOrange,
        .systemGreen,
        .systemRed,
        .systemYellow,
        .darkGray,
        .systemTeal
    ]
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
    
       // contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height: CGFloat = contentView.frame.height/2
        let width: CGFloat = contentView.frame.width/2
        nameLabel.frame = CGRect(x: 10, y: height, width: contentView.frame.width - 20, height: height)
        image.frame = CGRect(x: width, y: 10, width: width, height: height)
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        image.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
    }
    
    func configure(with title: String) {
        nameLabel.text = title
        
        contentView.backgroundColor = colors.randomElement()
        //image.sd_setImage(with: viewModel.image, completed: nil)
    }
}
