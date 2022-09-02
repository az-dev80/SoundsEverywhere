//
//  Router.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 1.11.21.
//

import UIKit
import CoreData

protocol MainRouterProtocol {
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterTabBarProtocol: MainRouterProtocol {
    func passTabBar() -> UITabBarController
}

class RouterTabBar: RouterTabBarProtocol {
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(assemblyBuilder: AssemblyBuilderProtocol){
        self.assemblyBuilder = assemblyBuilder
    }
    
    func passTabBar() -> UITabBarController {
        let tabBar = assemblyBuilder?.createTabBar(router: self)
        return tabBar!
    }
}

//protocol RouterProtocol {
//    func intnialVC() -> UIViewController
//    func showAddWalletVC()
//    func showColorVC(presenter: String)
//    func showCurrencyVC(presenter: String)
//    func showWalletDetalsVC(wallet: NSManagedObject, walletIndex: IndexPath)
//    func showAddTransactionVC(wallet: NSManagedObject)
//    func showAllTransactionsVC(wallet: NSManagedObject, array: [[String]])
//    func showTransactionDetailsVC(wallet: NSManagedObject, array: [[String]], presenter: String, indexPath: IndexPath)
//    func showChangeTransactionVC(wallet: NSManagedObject, arrayAll: [[String]], arrayTransaction: [String], indexPath: IndexPath)
//    func showChangeWalletVC(wallet: NSManagedObject, walletIndex: IndexPath)
//}
//
//class Router: RouterProtocol{
//
//    var viewController: UIViewController?
//    var viewController1: UIViewController?
//    var viewController2: UIViewController?
//    var viewController3: UIViewController?
//    var viewController4: UIViewController?
//    var viewController5: UIViewController?
//    var viewController6: UIViewController?
//    var viewController7: UIViewController?
//    var viewController8: UIViewController?
//    var viewController9: UIViewController?
//    var assemblyBuilder: AssemblyBuilderProtocol?
//
//    init(viewController: UIViewController, assemblyBuilder: AssemblyBuilderProtocol){
//        self.viewController = viewController
//        self.assemblyBuilder = assemblyBuilder
//    }
//
//    func intnialVC() -> UIViewController {
//        viewController = assemblyBuilder?.createWalletsModule(router: self)
//        return viewController!
//    }
//
//    func showAddWalletVC() {
////        if let viewController = viewController {
////            guard let viewController1 = assemblyBuilder?.createAddWalletModule(router: self) else { return }
////            viewController1.modalPresentationStyle = .overCurrentContext
////            viewController.present(viewController1, animated: true, completion: nil)
////        }
//        viewController1 = assemblyBuilder?.createAddWalletModule(router: self)
//        viewController1!.modalPresentationStyle = .overCurrentContext
//        viewController!.present(viewController1!, animated: true, completion: nil)
//    }
//
//    func showColorVC(presenter: String) {
//        viewController2 = assemblyBuilder?.createColorSchemeModule(router: self)
//        viewController2!.modalPresentationStyle = .overCurrentContext
//        if presenter == "WalletDetails" {
//            viewController9!.present(viewController2!, animated: true, completion: nil)
//        } else {
//            viewController1!.present(viewController2!, animated: true, completion: nil)
//        }
//    }
//
//    func showCurrencyVC(presenter: String) {
//        viewController3 = assemblyBuilder?.createCurrencyModule(router: self)
//        viewController3!.modalPresentationStyle = .overCurrentContext
//        if presenter == "WalletDetails" {
//            viewController9!.present(viewController3!, animated: true, completion: nil)
//        } else {
//            viewController1!.present(viewController3!, animated: true, completion: nil)
//        }
//    }
//
//    func showWalletDetalsVC(wallet: NSManagedObject, walletIndex: IndexPath) {
//        viewController4 = assemblyBuilder?.createWalletDetailsModule(router: self, wallet: wallet, walletIndex: walletIndex)
//        viewController4!.modalPresentationStyle = .overCurrentContext
//        viewController!.present(viewController4!, animated: true, completion: nil)
//    }
//
//    func showAddTransactionVC(wallet: NSManagedObject){
//        viewController5 = assemblyBuilder?.createAddTransactionModule(router: self, wallet: wallet)
//        viewController5!.modalPresentationStyle = .overCurrentContext
//        viewController4!.present(viewController5!, animated: true, completion: nil)
//    }
//
//    func showAllTransactionsVC(wallet: NSManagedObject, array: [[String]]) {
//        viewController6 = assemblyBuilder?.createAllTransactionsModule(router: self, wallet: wallet, array: array)
//        viewController6!.modalPresentationStyle = .overCurrentContext
//        viewController4!.present(viewController6!, animated: true, completion: nil)
//    }
//
//    func showTransactionDetailsVC(wallet: NSManagedObject, array: [[String]], presenter: String, indexPath: IndexPath) {
//        viewController7 = assemblyBuilder?.createTransactionDetailsModule(router: self, wallet: wallet, array: array, indexPath: indexPath)
//        viewController7!.modalPresentationStyle = .overCurrentContext
//
//        if presenter == "AllTransactionsPresenter" {
//            viewController6!.present(viewController7!, animated: true, completion: nil)
//        } else {
//            viewController4!.present(viewController7!, animated: true, completion: nil)
//        }
//    }
//
//    func showChangeTransactionVC(wallet: NSManagedObject, arrayAll: [[String]], arrayTransaction: [String], indexPath: IndexPath) {
//        viewController8 = assemblyBuilder?.createChangeTransactionModule(router: self, wallet: wallet, arrayAll: arrayAll, arrayTransaction: arrayTransaction, indexPath: indexPath)
//        viewController8!.modalPresentationStyle = .overCurrentContext
//        viewController7!.present(viewController8!, animated: true, completion: nil)
//    }
//
//    func showChangeWalletVC(wallet: NSManagedObject, walletIndex: IndexPath) {
//        viewController9 = assemblyBuilder?.createChangeWalletModule(router: self, wallet: wallet, walletIndex: walletIndex)
//        viewController9!.modalPresentationStyle = .overCurrentContext
//        viewController4!.present(viewController9!, animated: true, completion: nil)
//    }
//}
