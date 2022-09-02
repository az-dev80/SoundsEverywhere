//
//  ProfileVC.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 3.11.21.
//

import UIKit
import SDWebImage
import Gradients

class ProfileVC: UIViewController {

    let tableView: UITableView = {
        let tv = UITableView()
        tv.isHidden = true
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tv
    }()
    
    var models = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .semibold)]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor:UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        view.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        getProfile()
        
        
    }
    
    private func getProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.updateView(with: model)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.failed()
                }
            }
            
        }
    }
    
    private func updateView(with model: UserProfile) {
        tableView.isHidden = false
        models.append("User name: \(model.username)")
        models.append("Email: \(model.email)")
        models.append("Home page: \(model.homePage)")
        models.append("User ID: \(model.uniqueID)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date = dateFormatter.date(from: model.dateJoined)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let dateString = dateFormatter.string(from: date!)
        models.append("Join date: \(dateString)")
       // models.append("About me: \(model.about)")
        createTableHeader(with: model.avatar.large)
        tableView.reloadData()
    }
    
    private func createTableHeader(with string: String?) {
        guard let urlString = string, let url = URL(string: urlString) else { return }
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/1.5))
        
        let imageSize: CGFloat = header.frame.size.height/2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        header.addSubview(imageView)
        imageView.center = header.center
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: url, completed: nil)
        imageView.layer.cornerRadius = imageSize/2
        imageView.layer.masksToBounds = true
        
        tableView.tableHeaderView = header
    }
//    url: "https://freesound.org/people/testID1/",
//
//    avatar: rss_ios_stage3_final_task.Avatar(small: "https://freesound.org/data/avatars/13402/13402569_S.jpg", large: "https://freesound.org/data/avatars/13402/13402569_L.jpg", medium: "https://freesound.org/data/avatars/13402/13402569_M.jpg"),
//    dateJoined: "2021-10-29T18:31:22.550277",
//    numSounds: 0,
//    sounds: "https://freesound.org/apiv2/users/testID1/sounds/",
//    numPacks: 0,
//    packs: "https://freesound.org/apiv2/users/testID1/packs/",
//    numPosts: 0,
//    numComments: 0,
//    bookmarkCategories: "https://freesound.org/apiv2/users/testID1/bookmark_categories/"
    
    private func failed() {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Failed to load profile"
        lbl.sizeToFit()
        lbl.textColor = .secondaryLabel
        view.addSubview(lbl)
        lbl.center = view.center
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        let gradientLayer = Gradients.winterNeva.layer
//        gradientLayer.frame = self.view.bounds
//
//        self.view.layer.insertSublayer(gradientLayer, at:0)
        
       // view.insertSubview(GradientBG(frame: view.frame), at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.backgroundColor = .clear
//        let gradientLayer = Gradients.gagarinView.layer
//        gradientLayer.frame = self.view.bounds
//
//        self.view.layer.insertSublayer(gradientLayer, at:0)
        let gradientLayer = Gradients.solidStone.layer
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = models[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
//        let aview = GradientBG(frame: cell.frame)
//
//        cell.backgroundView = aview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
extension ProfileVC: UIScrollViewDelegate {
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
