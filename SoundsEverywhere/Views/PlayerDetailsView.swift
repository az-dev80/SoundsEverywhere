//
//  PlayerDetailsView.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 13.11.21.
//

import Foundation
import UIKit

struct PlayerDetailsViewViewModel {
    let name, type, duration, downloads, rating, created, licence, username, id: String?
}

final class PlayerDetailsView: UIView {
    
    private let nameLabel = UILabel()
    
    private let typeLabel = UILabel()
    private let durationLabel = UILabel()
    private let downloadsLabel = UILabel()
    private let ratingLabel = UILabel()
    private let createdLabel = UILabel()
   // private let licenceLabel = UILabel()
    private let usernameLabel = UILabel()
    private let idLabel = UILabel()
    
    private let typeValueLabel = UILabel()
    private let durationValueLabel = UILabel()
    private let downloadsValueLabel = UILabel()
    private let ratingValueLabel = UILabel()
    private let createdValueLabel = UILabel()
  //  private let licenceValueLabel = UILabel()
    private let usernameValueLabel = UILabel()
    private let idValueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        configureLabel(label: typeLabel, text: "Type:")
        configureLabel(label: durationLabel, text: "Duration:")
        configureLabel(label: downloadsLabel, text: "Downloads:")
        configureLabel(label: ratingLabel, text: "Rating:")
        configureLabel(label: createdLabel, text: "Created:")
        //configureLabel(label: licenceLabel, text: "Licence:")
        configureLabel(label: usernameLabel, text: "Uploader:")
        configureLabel(label: idLabel, text: "Sound ID:")
        
        configureValueLabel(label: nameLabel, fontSize: 20, fontWeight: .bold, fontColor: .systemGray3)
        configureValueLabel(label: typeValueLabel)
        configureValueLabel(label: durationValueLabel)
        configureValueLabel(label: downloadsValueLabel)
        configureValueLabel(label: ratingValueLabel)
        configureValueLabel(label: createdValueLabel)
        //configureValueLabel(label: licenceValueLabel)
        configureValueLabel(label: usernameValueLabel)
        configureValueLabel(label: idValueLabel)
       
        //constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //configureValueLabel(label: nameLabel, fontSize: 20, fontWeight: .bold)
        constraints()
    }
    
    func configureDetails(with viewModel: PlayerDetailsViewViewModel) {
        nameLabel.text = viewModel.name?.capitalized
        typeValueLabel.text = viewModel.type?.capitalized
        durationValueLabel.text = viewModel.duration?.capitalized
        downloadsValueLabel.text = viewModel.downloads?.capitalized
        ratingValueLabel.text = viewModel.rating?.capitalized
        createdValueLabel.text = viewModel.created?.capitalized
        //licenceValueLabel.text = viewModel.licence?.capitalized
        usernameValueLabel.text = viewModel.username?.capitalized
        idValueLabel.text = viewModel.id?.capitalized
        
    }
    
    private func configureLabel(label: UILabel, text: String) {
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.text = text
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 16, weight: .bold)
        addSubview(label)
    }
    
    private func configureValueLabel(label: UILabel, fontSize: CGFloat = 16, fontWeight: UIFont.Weight = .semibold, fontColor: UIColor = .systemGray) {
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = fontColor
        label.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        addSubview(label)
    }
    
    private func constraints() {
        let padding = frame.width*0.05
        let multipl = padding*2
        let multipl3 = padding*3
        let height = frame.height/6
        let startPoint = (frame.width - padding)/2
        let startValue = startPoint/2
        let secondValue = frame.width*3/4
        
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: frame.width - padding).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: height*2).isActive = true
        
        typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        typeLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
        typeLabel.heightAnchor.constraint(equalToConstant: height).isActive = true

        durationLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 0).isActive = true
        durationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        durationLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
        durationLabel.heightAnchor.constraint(equalToConstant: height).isActive = true

        downloadsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        downloadsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: startPoint - multipl).isActive = true
        downloadsLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
        downloadsLabel.heightAnchor.constraint(equalToConstant: height).isActive = true

        ratingLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 0).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: height).isActive = true

        createdLabel.topAnchor.constraint(equalTo: downloadsLabel.bottomAnchor, constant: 0).isActive = true
        createdLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: startPoint - multipl).isActive = true
        createdLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
        createdLabel.heightAnchor.constraint(equalToConstant: height).isActive = true

//        licenceLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 0).isActive = true
//        licenceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: startPoint).isActive = true
//        licenceLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
//        licenceLabel.heightAnchor.constraint(equalToConstant: height).isActive = true

        usernameLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 0).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        usernameLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: height).isActive = true

        idLabel.topAnchor.constraint(equalTo: createdLabel.bottomAnchor, constant: 0).isActive = true
        idLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: startPoint - multipl).isActive = true
        idLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant: height).isActive = true

        typeValueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        typeValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: startValue).isActive = true
        typeValueLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
        typeValueLabel.heightAnchor.constraint(equalToConstant: height).isActive = true

        durationValueLabel.topAnchor.constraint(equalTo: typeValueLabel.bottomAnchor, constant: 0).isActive = true
        durationValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: startValue).isActive = true
        durationValueLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
        durationValueLabel.heightAnchor.constraint(equalToConstant: height).isActive = true

        downloadsValueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        downloadsValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: secondValue - multipl3).isActive = true
        downloadsValueLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
        downloadsValueLabel.heightAnchor.constraint(equalToConstant: height).isActive = true

        ratingValueLabel.topAnchor.constraint(equalTo: durationValueLabel.bottomAnchor, constant: 0).isActive = true
        ratingValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: startValue).isActive = true
        ratingValueLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
        ratingValueLabel.heightAnchor.constraint(equalToConstant: height).isActive = true

        createdValueLabel.topAnchor.constraint(equalTo: downloadsValueLabel.bottomAnchor, constant: 0).isActive = true
        createdValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: secondValue - multipl3).isActive = true
        createdValueLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
        createdValueLabel.heightAnchor.constraint(equalToConstant: height).isActive = true

//        licenceValueLabel.topAnchor.constraint(equalTo: ratingValueLabel.bottomAnchor, constant: 0).isActive = true
//        licenceValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: secondValue).isActive = true
//        licenceValueLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
//        licenceValueLabel.heightAnchor.constraint(equalToConstant: height).isActive = true

        usernameValueLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 0).isActive = true
        usernameValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: startValue).isActive = true
        usernameValueLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
        usernameValueLabel.heightAnchor.constraint(equalToConstant: height).isActive = true

        idValueLabel.topAnchor.constraint(equalTo: createdLabel.bottomAnchor, constant: 0).isActive = true
        idValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: secondValue - multipl3).isActive = true
        idValueLabel.widthAnchor.constraint(equalToConstant: startValue).isActive = true
        idValueLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
}
