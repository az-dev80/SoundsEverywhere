//
//  WelcomeVC.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 1.11.21.
//

import UIKit
import Gradients

class WelcomeVC: UIViewController {
    
    private var gradientLayer: CALayer!
    private var gradientLayer1: CALayer!
    
    private let welcomeLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Welcome to Freesounds"
        lb.font = .systemFont(ofSize: 32, weight: .bold)
        lb.textAlignment = .center
        lb.textColor = .white
        lb.adjustsFontSizeToFitWidth = true
        
        return lb
    }()
    
    private let subLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Don't waste your time, just log in"
        lb.font = .systemFont(ofSize: 26, weight: .semibold)
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.textColor = .white
        lb.adjustsFontSizeToFitWidth = true
        
        return lb
    }()
    
    private let signInButton: UIButton = {
        let bt = UIButton()
        //bt.backgroundColor = .white
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Sign in", for: .normal)
        bt.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        bt.setTitleColor(.white, for: .normal)
        bt.layer.cornerRadius = 8
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.white.cgColor
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sounds Everywhere"
        
        gradientLayer = Gradients.solidStone.layer
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .semibold)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        view.addSubview(welcomeLabel)
        view.addSubview(subLabel)
        
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        gradientLayer1 = Gradients.eternalConstance.layer
        gradientLayer1.cornerRadius = 8
        signInButton.layer.insertSublayer(gradientLayer1, at:0)
        
        constraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = self.view.bounds
        gradientLayer1.frame = self.signInButton.bounds
    }
    
    private func constraints() {
        let heightConstant = view.frame.height/5
        let padding = view.frame.width*0.1
        welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: heightConstant).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        welcomeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        subLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: heightConstant).isActive = true
        subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        subLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func signInAction() {
        let vc = AuthVC()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
    }
    
    private func handleSignIn(success: Bool) {
        guard success else {
            let alert = UIAlertController(title: "Huston", message: "You have a problem with signing in", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return }
        
        let assemblyBuilder = AssemblyModelBuilder()
        let router = RouterTabBar(assemblyBuilder: assemblyBuilder)
        let tabBar = router.passTabBar() as! TabBarVC
        tabBar.presenter.configureTabBar(view: tabBar)
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true, completion: nil)
        //navigationController?.popToRootViewController(animated: true)
        
        //dismiss(animated: true, completion: nil)
        
        
    }

}
