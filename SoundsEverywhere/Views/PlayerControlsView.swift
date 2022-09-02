//
//  PlayerControlsView.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 8.11.21.
//

import Foundation
import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPauseButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapBackButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidSliding(_ playerControlsView: PlayerControlsView, slider value: Float)
    func playerControlsViewDidSlidingTime(_ playerControlsView: PlayerControlsView, slider: UISlider, label: UILabel)
}

final class PlayerControlsView: UIView {
    
    private var isPlaying = true
    
    weak var delegate: PlayerControlsViewDelegate?
    
    private let volumeSlider: UISlider = {
        let sl = UISlider()
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.value = 0.5
        return sl
    }()
    
//    private let nameLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.numberOfLines = 1
//        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
//
//        return lbl
//    }()
    
     let timeSlider: UISlider = {
        let sl = UISlider()
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.value = 0.0
        sl.tintColor = .systemGray3
        return sl
    }()
    
     let timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.text = "00:00"
        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
        lbl.textColor = .systemGray3
        return lbl
    }()
    
    private let speakerImage:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.image = UIImage(systemName: "speaker.wave.1.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .regular))
        img.tintColor = .systemGray3
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
//    private let subNameLabel: UILabel = {
//        let lbl = UILabel()
//        lbl.numberOfLines = 1
//        lbl.font = .systemFont(ofSize: 18, weight: .regular)
//        lbl.backgroundColor = .secondaryLabel
//
//        return lbl
//    }()
    
    private let backButton: UIButton = {
        let bt = UIButton()
        bt.titleLabel?.textColor = .systemGray3
        bt.setTitle("Download sound", for: .normal) 
        bt.titleLabel?.textAlignment = .center
        bt.layer.cornerRadius = 8
        bt.layer.borderWidth = 2
        bt.layer.borderColor = UIColor.white.cgColor
        //let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        //bt.setImage(image, for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    private let forwardButton: UIButton = {
        let bt = UIButton()
        bt.tintColor = .systemGray3
        bt.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "repeat", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .regular))
        bt.setImage(image, for: .normal)
        
        return bt
    }()
    
    private let pauseButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.tintColor = .systemGray3
        let image = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .regular))
        bt.setImage(image, for: .normal)
        bt.clipsToBounds = true
        return bt
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(speakerImage)
        addSubview(volumeSlider)
        
//        addSubview(subNameLabel)
        addSubview(backButton)
        
        addSubview(forwardButton)
        addSubview(pauseButton)
        addSubview(timeSlider)
        addSubview(timeLabel)
        
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(forwardButtonAction), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseButtonAction), for: .touchUpInside)
        
        volumeSlider.addTarget(self, action: #selector(sliding), for: .valueChanged)
        timeSlider.addTarget(self, action: #selector(slidingTime), for: .valueChanged)
        
     }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //nameLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: 50)
        //subNameLabel.frame = CGRect(x: 0, y: nameLabel.frame.height + 10, width: frame.width, height: 50)
        
        constraints()
        
//        volumeSlider.frame = CGRect(x: 10, y: 10 , width: frame.width - 20, height: 44)
//
//        timeSlider.frame = CGRect(x: 10, y: 64, width: frame.width - 20, height: 44)
//        timeLabel.frame = CGRect(x: 0, y: 64 + 54, width: frame.width, height: 50)
//
//        let size: CGFloat = 60
//        pauseButton.frame = CGRect(x: (frame.width - size)/2, y: volumeSlider.frame.height + 100, width: size, height: size)
//        backButton.frame = CGRect(x: 20, y: volumeSlider.frame.height + 100, width: size, height: size)
//        forwardButton.frame = CGRect(x: frame.width - size - 20, y: volumeSlider.frame.height + 100, width: size, height: size)
        
    
    }
    
    @objc func sliding(_ slider: UISlider) {
        let value = slider.value
        delegate?.playerControlsViewDidSliding(self, slider: value)
    }
    
    @objc func slidingTime(_ slider: UISlider) {
        delegate?.playerControlsViewDidSlidingTime(self, slider: slider, label: timeLabel)
        
        let minutes = slider.value/60
        let seconds = slider.value.truncatingRemainder(dividingBy: 60)
        let timeFormatter = NumberFormatter()
        timeFormatter.minimumIntegerDigits = 2
        timeFormatter.minimumFractionDigits = 0
        timeFormatter.roundingMode = .down
        
        guard let stringMinutes = timeFormatter.string(from: NSNumber(value: minutes)), let stringSeconds = timeFormatter.string(from: NSNumber(value: seconds)) else { return }
        timeLabel.text = "\(stringMinutes):\(stringSeconds)"
    }
    
    @objc func backButtonAction() {
        delegate?.playerControlsViewDidTapBackButton(self)
    }
    
    @objc func forwardButtonAction() {
        delegate?.playerControlsViewDidTapForwardButton(self)
    }
    
    @objc func pauseButtonAction() {
        self.isPlaying = !isPlaying
        print("TappedView")
        delegate?.playerControlsViewDidTapPauseButton(self)
        
        let pause = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .regular))
        let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .regular))
        
        pauseButton.setImage(isPlaying ? pause : play, for: .normal)
        print("TappedView")
    }
    
    private func constraints() {
      
        let padding = frame.width*0.05
        let heightConstant = frame.height*0.50
        backButton.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -padding).isActive = true
        
        pauseButton.topAnchor.constraint(equalTo: topAnchor, constant: heightConstant).isActive = true
        pauseButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        timeLabel.centerYAnchor.constraint(equalTo: pauseButton.centerYAnchor).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: pauseButton.trailingAnchor, constant: padding).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: timeLabel.intrinsicContentSize.width).isActive = true
        //timeLabel.intrinsicContentSize.width
        timeSlider.centerYAnchor.constraint(equalTo: pauseButton.centerYAnchor).isActive = true
        timeSlider.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: padding).isActive = true
        timeSlider.heightAnchor.constraint(equalToConstant: 25).isActive = true
        timeSlider.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor, constant: -padding).isActive = true

        forwardButton.centerYAnchor.constraint(equalTo: pauseButton.centerYAnchor).isActive = true
        forwardButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        forwardButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        forwardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true

        speakerImage.bottomAnchor.constraint(equalTo: pauseButton.topAnchor, constant: -20).isActive = true
        speakerImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        speakerImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
        speakerImage.widthAnchor.constraint(equalToConstant: 25).isActive = true

        volumeSlider.centerYAnchor.constraint(equalTo: speakerImage.centerYAnchor).isActive = true
        volumeSlider.leadingAnchor.constraint(equalTo: speakerImage.trailingAnchor, constant: padding).isActive = true
        volumeSlider.heightAnchor.constraint(equalToConstant: 25).isActive = true
        volumeSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        
    }
    
}
