//
//  PlayerVC.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 8.11.21.
//

import UIKit
import AVFoundation
import SDWebImage
import Gradients

protocol PlayerViewControllerDelegate: AnyObject {
    func pauseAction()
    func backAction()
    func forwardAction()
    func sliding(_ value: Float)
    func slidingTime(slider: UISlider, label: UILabel)
}

class PlayerVC: UIViewController {

    weak var dataSource: PlayerDataSource?
    weak var delegate: PlayerViewControllerDelegate?
    var player: AVPlayer!
    private var gradientLayer: CALayer!
    var fileURL: URL?
    
    private let progressView = UIProgressView()
    let progress = Progress(totalUnitCount: 1000005)
    private let controlsView = PlayerControlsView()
    private let detailsView = PlayerDetailsView()
    private let imageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    init(player: AVPlayer) {
        self.player = player
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        gradientLayer = Gradients.solidStone.layer
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(imageView)
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = UIColor(red: 0.14, green: 0.22, blue: 0.29, alpha: 0.5)
        view.addSubview(detailsView)
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controlsView)
        controlsView.translatesAutoresizingMaskIntoConstraints = false
        controlsView.delegate = self
        
        controlsView.timeSlider.maximumValue = Float(player.currentItem?.asset.duration.seconds ?? 0.0)
        var valueProgress:Float = 0
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: .main) { time in
            let minutes = time.seconds/60
            let seconds = time.seconds.truncatingRemainder(dividingBy: 60)
            let timeFormatter = NumberFormatter()
            timeFormatter.minimumIntegerDigits = 2
            timeFormatter.minimumFractionDigits = 0
            timeFormatter.roundingMode = .down
            
            guard let stringMinutes = timeFormatter.string(from: NSNumber(value: minutes)), let stringSeconds = timeFormatter.string(from: NSNumber(value: seconds)) else { return }
            
            self.controlsView.timeLabel.text = "\(stringMinutes):\(stringSeconds)"
            self.controlsView.timeSlider.value = Float(time.seconds)
            
            if let x = self.player.currentItem?.asset.duration.seconds {
                valueProgress = Float(self.progress.totalUnitCount)/Float(x)
            }
            if Int(time.seconds) >= 1 {
                self.progress.completedUnitCount += Int64(valueProgress)
            }
            self.progressView.setProgress(Float(self.progress.fractionCompleted), animated: true)
        }
        
        configureBarButtons()
        configure()
        
        constraints()
     }
    
    private func constraints() {
        let height1 = view.frame.height*0.30
        let height2 = view.frame.height*0.31
        let height3 = view.frame.height*0.39
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: height1).isActive = true
        
        progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -1).isActive = true
        progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 1).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: height1).isActive = true
        
        detailsView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        detailsView.heightAnchor.constraint(equalToConstant: height2).isActive = true
        
        controlsView.topAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 0).isActive = true
        controlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        controlsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        controlsView.heightAnchor.constraint(equalToConstant: height3).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
        
//        imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.width)
//        progressView.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.frame.width - 20, height: view.frame.width)
//        controlsView.frame = CGRect(x: 10, y: view.safeAreaInsets.top + view.frame.width + 10, width: view.frame.width - 20, height: view.frame.height - imageView.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 15)
    }
    
    private func configure() {
        imageView.sd_setImage(with: dataSource?.imgURL, completed: nil)
        
        detailsView.configureDetails(with: PlayerDetailsViewViewModel(
                                        name: dataSource?.soundName,
                                        type: dataSource?.type,
                                        duration: dataSource?.duration,
                                        downloads: dataSource?.downloads,
                                        rating: dataSource?.rating,
                                        created: dataSource?.created,
                                        licence: dataSource?.licence,
                                        username: dataSource?.subname,
                                        id: dataSource?.id))
    }
    
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(tappedCloseButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(tappedActionButton))
    }
    
    @objc func tappedCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func tappedActionButton() {
        
    }
    
    func refreshUI() {
        configure()
    }
}

extension PlayerVC: PlayerControlsViewDelegate {
    func playerControlsViewDidTapPauseButton(_ playerControlsView: PlayerControlsView) {
        delegate?.pauseAction()
        print("TappedDelegate")
    }
    
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
        delegate?.forwardAction()
        progress.completedUnitCount = 0
        progressView.progress = 0
    }
    
    func playerControlsViewDidTapBackButton(_ playerControlsView: PlayerControlsView) {
        //delegate?.backAction()
        guard let url = URL(string: dataSource?.downLoadURL ?? "") else { return }
        APICaller.shared.createRequest(with: url, type: .GET) { request in
            print(request)
            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
            let task = urlSession.downloadTask(with: request)
            task.resume()
        }
    }
    
    func playerControlsViewDidSliding(_ playerControlsView: PlayerControlsView, slider value: Float) {
        delegate?.sliding(value)
    }
    
    func playerControlsViewDidSlidingTime(_ playerControlsView: PlayerControlsView, slider: UISlider, label: UILabel) {
        delegate?.slidingTime(slider: slider, label: label)
        //print(slider.value)
        var valueProgress:Float = 0
        if let x = player.currentItem?.asset.duration.seconds {
            valueProgress = Float(progress.totalUnitCount)*Float(slider.value)/Float(x)
        }
        progress.completedUnitCount = Int64(valueProgress)
        progressView.progress = slider.value/Float((player.currentItem?.asset.duration.seconds)!)
    }
}

extension PlayerVC: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let url = downloadTask.originalRequest?.url else { return }
        
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let destination = path.appendingPathComponent(url.lastPathComponent)
        try? FileManager.default.removeItem(at: destination)
        do {
            try FileManager.default.copyItem(at: location, to: destination)
            print("Your sound has been saved at path: \(destination)")
            self.fileURL = destination
           
//            if let topController = UIApplication.topViewController(base: self) {
//                topController.present(alert, animated: true, completion: nil)
//
//            } else {
//                // If all else fails, attempt to present the alert from this controller.
//                self.present(alert, animated: true, completion: nil)
//
//            }
            //present(alert, animated: true, completion: nil)
            
        } catch let error {
            print(error.localizedDescription)
        }
//        let alert = UIAlertController(title: "Downloading completed", message: "You may thank an author for the sound", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//        alert.show()
    }
    
}
