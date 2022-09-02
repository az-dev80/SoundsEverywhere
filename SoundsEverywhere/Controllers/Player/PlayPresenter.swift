//
//  PlayPresenter.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 8.11.21.
//

import Foundation
import UIKit
import  AVFoundation

protocol PlayerDataSource: AnyObject {
    var soundName: String? { get }
    var subname: String? { get }
    var imgURL: URL? { get }
    var type: String? { get }
    var duration: String? { get }
    var downloads: String? { get }
    var rating: String? { get }
    var created: String? { get }
    var licence: String? { get }
    var id: String? { get }
    var downLoadURL: String? { get }
    var urlForWeb: String? { get }
}

final class PlayPresenter {
    
    static let shared = PlayPresenter()
    
    private var sound: Resulter?
    private var sounds = [Resulter]()
    
    var index = 0
    
    var playerVC: PlayerVC?
    
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    var currentSound: Resulter? {
        if let sound = sound, sounds.isEmpty {
            return sound
        } else if let player = self.playerQueue, !sounds.isEmpty {
//            let item = player.currentItem
//            let items = player.items()
//            guard let index = items.firstIndex(where: { $0 == item }) else { return nil }
            return sounds[index]
        }
        return nil
    }
    
    func startPlaying(from viewController: UIViewController, sound: Resulter){
        
        guard let url = URL(string: sound.previews.previewHqMp3) else { return }
        player = AVPlayer(url: url)
        player?.volume = 0.4
        
        self.sound = sound
        self.sounds = []
        
        let vc = PlayerVC(player: player!)
        vc.title = sound.name.capitalized
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
    }
    
    func startPlaying(from viewController: UIViewController, sounds: [Resulter], index: Int){
        
//        guard let url = URL(string: sound.previews.previewHqMp3) else { return }
//        player = AVPlayer(url: url)
//        player?.volume = 0.1
        
        self.sounds = sounds
        self.sound = nil
        
       
        
        self.playerQueue = AVQueuePlayer(items: sounds.compactMap({
            guard let url = URL(string: $0.previews.previewHqMp3) else {
                return nil
            }
            return AVPlayerItem(url: url)
        }))
        playerQueue?.replaceCurrentItem(with: AVPlayerItem(url: URL(string: sounds[index].previews.previewHqMp3)! ))
        self.playerQueue?.volume = 0.2
        
        
        let backgroundQueue = DispatchQueue.global(qos: .background)
        backgroundQueue.async {
            self.playerQueue?.play()
        }
        let vc = PlayerVC(player: playerQueue!)
        //vc.title = sound.name.capitalized
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        self.playerVC = vc
    }
    
    
}

extension PlayPresenter: PlayerDataSource {
    var urlForWeb: String? {
        return currentSound?.url
    }
    
    var downLoadURL: String? {
        return currentSound?.download
    }
    
    var type: String? {
        return currentSound?.type.rawValue
    }
    
    var duration: String? {
        if let x = currentSound?.durationValue {
            let minutes = x/60
            let seconds = x.truncatingRemainder(dividingBy: 60)
            let timeFormatter = NumberFormatter()
            timeFormatter.minimumIntegerDigits = 2
            timeFormatter.minimumFractionDigits = 0
            timeFormatter.roundingMode = .down
            
            guard let stringMinutes = timeFormatter.string(from: NSNumber(value: minutes)), let stringSeconds = timeFormatter.string(from: NSNumber(value: seconds)) else { return "00:00" }
            
            return "\(stringMinutes):\(stringSeconds)"
        }
        return "No data"
    }
    
    var downloads: String? {
        if let x = currentSound?.numDownloads {
            return "\(x)"
        }
        return "No data"
    }
    
    var rating: String? {
        if let x = currentSound?.avgRating {
            print("Rating1: \(x)")
            return String(format: "%.1f", x)
        }
        return "No data"
    }
    
    var created: String? {
        if let x = currentSound?.created {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from: x)
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            return dateFormatter.string(from: date!)
        }
        return "No data"
    }
    
    var licence: String? {
        return currentSound?.license
    }
    
    var id: String? {
        if let x = currentSound?.id {
            return "\(x)"
        }
        return "No data"
    }
    
    var soundName: String? {
        return currentSound?.name
    }
    
    var subname: String? {
        return currentSound?.username
    }
    
    var imgURL: URL? {
        return URL(string: currentSound?.images.waveformBWM ?? "")
    }
    
    
}

extension PlayPresenter: PlayerViewControllerDelegate {
    
    func pauseAction() {
        print("Tapped")
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            } else {
                player.play()
            }
        }
        else if let player = playerQueue {
            print(player.timeControlStatus)
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func backAction() {
        if sounds.isEmpty {
            player?.pause()
            player?.play()
        }
        else if let firstSound = playerQueue?.items().first {
            playerQueue?.pause()
            playerQueue?.removeAllItems()
            playerQueue = AVQueuePlayer(items: [firstSound])
            playerQueue?.play()
            playerQueue?.volume = 0.2
        }
    }
    
    func forwardAction() {
        player?.seek(to: CMTime.zero)
        player?.play()
//        if sounds.isEmpty {
//            player?.pause()
//        }
//        else if let player = playerQueue {
//            player.advanceToNextItem()
//            playerVC?.refreshUI()
//        }
    }
    
    func sliding(_ value: Float) {
        player?.volume = value
    }
    
    func slidingTime(slider: UISlider, label: UILabel){
        player?.seek(to: CMTime(seconds: Double(slider.value), preferredTimescale: 1000))
        
    }
}
