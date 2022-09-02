//
//  SoundVC.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 6.11.21.
//

//import UIKit
//
//class SoundVC: UIViewController {
//
//    private let sound: Resulter
//    
//    private let rating: UILabel = {
//        let lbl = UILabel()
//        
//        return lbl
//    }()
//    
//    init(sound: Resulter) {
//        self.sound = sound
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //title = "Sound"
//        view.backgroundColor = .systemBackground
//
//        title = sound.name
//        rating.text = String(format: "%.1f", sound.avgRating)
//    }
//    
//}
