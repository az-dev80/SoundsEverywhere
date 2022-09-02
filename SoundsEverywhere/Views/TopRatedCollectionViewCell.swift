//
//  TopRatedCollectionViewCell.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 6.11.21.
//

import UIKit
import SDWebImage

class TopRatedCollectionViewCell: UICollectionViewCell {
    static let identifier = "TopRatedCollectionViewCell"
    let aview = UIView()
    let shape = CAShapeLayer()
    
    private let image: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.layer.borderWidth = 2
        img.layer.borderColor = UIColor(red: 0.11, green: 0.31, blue: 0.46, alpha: 1.00).cgColor
        return img
    }()
    
    private let nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 20, weight: .semibold)
        lb.adjustsFontSizeToFitWidth = true
        lb.textColor = .systemGray4
        return lb
    }()
    
    private let usernameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 17, weight: .regular)
        lb.adjustsFontSizeToFitWidth = true
        lb.textColor = .systemGray3
        return lb
    }()
    
    private let downloadsLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 17, weight: .regular)
        lb.adjustsFontSizeToFitWidth = true
        lb.textColor = .systemGray3
        return lb
    }()
    
    private let ratingLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .systemFont(ofSize: 25, weight: .regular)
        lb.adjustsFontSizeToFitWidth = true
        lb.textColor = .systemGray3
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        shape.lineWidth = 3
        shape.strokeColor = UIColor.systemGray3.cgColor
        shape.fillColor = UIColor.clear.cgColor
        aview.layer.addSublayer(shape)
        aview.layer.shadowPath = shape.path
        aview.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        aview.layer.shadowOpacity = 1
        aview.layer.shadowRadius = 100
        aview.layer.shadowOffset = CGSize(width: 5, height: 5)
        backgroundView = aview
        
        contentView.layer.cornerRadius = 8
        //contentView.layer.borderWidth = 2.5
        //contentView.layer.borderColor = UIColor(red: 0.11, green: 0.31, blue: 0.46, alpha: 1.00).cgColor
        
        contentView.backgroundColor = .clear
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(downloadsLabel)
        contentView.addSubview(ratingLabel)
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
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding*3).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: padding).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -37).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        //downloadsLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 2).isActive = true
        downloadsLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: padding).isActive = true
        downloadsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -37).isActive = true
        downloadsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        downloadsLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 22).isActive = true
        
        ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70).isActive = true
        ratingLabel.widthAnchor.constraint(equalTo: ratingLabel.heightAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        aview.frame = bounds
        shape.path = UIBezierPath(roundedRect: aview.bounds, cornerRadius: 8).cgPath
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        usernameLabel.text = nil
        downloadsLabel.text = nil
        ratingLabel.text = nil
        image.image = nil
    }
    
    func configure(with viewModel: TopRatedCellViewModel) {
        nameLabel.text = viewModel.name.uppercased()
        usernameLabel.text = viewModel.userName.capitalized
        downloadsLabel.text = "Downloads: \(String(viewModel.numOfDownloads))"
        ratingLabel.text = "\(String(format: "%.1f",viewModel.rating))"
        image.sd_setImage(with: viewModel.image, completed: nil)
    }
}
