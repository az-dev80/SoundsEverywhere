//
//  LastSoundsCollectionViewCell.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 6.11.21.
//

import UIKit
import SDWebImage
import Gradients

class LastSoundsCollectionViewCell: UICollectionViewCell {
    static let identifier = "LastSoundsCollectionViewCell"
    let bottomBorder = CALayer()
    
    private let image: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 6
        img.layer.borderWidth = 2
        img.layer.borderColor = UIColor(red: 0.11, green: 0.31, blue: 0.46, alpha: 1.00).cgColor
        return img
    }()
    
    private let nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 15, weight: .semibold)
        //lb.adjustsFontSizeToFitWidth = true
        lb.lineBreakMode = .byTruncatingTail
        lb.textColor = .systemGray4
        return lb
    }()
    
    private let usernameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 13, weight: .regular)
        lb.adjustsFontSizeToFitWidth = true
        lb.textColor = .systemGray3
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        
        bottomBorder.backgroundColor = UIColor.white.cgColor
        contentView.layer.addSublayer(bottomBorder)
        
        contentView.layer.cornerRadius = 14
        //contentView.layer.borderWidth = 1
        //contentView.layer.borderColor = UIColor.white.cgColor
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
    
        contentView.clipsToBounds = true
        
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraints() {
        let padding = CGFloat(5)
        image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
        image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding).isActive = true
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        image.widthAnchor.constraint(equalTo: image.heightAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: padding).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: padding).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -37).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let thickness: CGFloat = 1.0
        bottomBorder.frame = CGRect(x:0, y: self.contentView.frame.size.height - thickness, width: self.contentView.frame.size.width, height:thickness)
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        usernameLabel.text = nil
        image.image = nil
    }
    
    func configure(with viewModel: LastSoundsCellViewModel) {
        nameLabel.text = viewModel.name.uppercased()
        usernameLabel.text = viewModel.userName.capitalized
        image.sd_setImage(with: viewModel.image, completed: nil)
    }
}
