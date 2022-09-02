//
//  AssemblyBuilder.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 1.11.21.
//

import UIKit
import CoreData

protocol AssemblyBuilderProtocol {
    func createTabBar(router: RouterTabBarProtocol) -> UITabBarController
//    func createWalletsModule(router: RouterProtocol) -> UIViewController
//    func createAddWalletModule(router: RouterProtocol) -> UIViewController
//    func createColorSchemeModule(router: RouterProtocol) -> UIViewController
//    func createCurrencyModule(router: RouterProtocol) -> UIViewController
//    func createWalletDetailsModule(router: RouterProtocol, wallet: NSManagedObject, walletIndex: IndexPath) -> UIViewController
//    func createAddTransactionModule(router: RouterProtocol, wallet: NSManagedObject) -> UIViewController
//    func createAllTransactionsModule(router: RouterProtocol, wallet: NSManagedObject, array: [[String]]) -> UIViewController
//    func createTransactionDetailsModule(router: RouterProtocol, wallet: NSManagedObject, array: [[String]], indexPath: IndexPath) -> UIViewController
//    func createChangeTransactionModule(router: RouterProtocol, wallet: NSManagedObject, arrayAll: [[String]], arrayTransaction: [String], indexPath: IndexPath) -> UIViewController
//    func createChangeWalletModule(router: RouterProtocol, wallet: NSManagedObject, walletIndex: IndexPath) -> UIViewController
}

class AssemblyModelBuilder: AssemblyBuilderProtocol {
    
    func createTabBar(router: RouterTabBarProtocol) -> UITabBarController {
        let view = TabBarVC()
        let presenter = TabBarPresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }

    
//    func createWalletsModule(router: RouterProtocol) -> UIViewController {
//        let view = ViewController()
//        let storageService = WalletsModel()
//        let presenter = WalletsPresenter(view: view, storageService: storageService, router: router)
//        view.presenter = presenter
//
//        return view
//    }
//
//    func createAddWalletModule(router: RouterProtocol) -> UIViewController {
//        let view = AddNewWalletVC()
//        let storageService = WalletsModel()
//        let presenter = AddWalletPresenter(view: view, storageService: storageService, router: router)
//        view.presenter = presenter
//
//        return view
//    }
//
//    func createCurrencyModule(router: RouterProtocol) -> UIViewController {
//        let view = CurrencyVC()
//        let storageService = CurrencyModel()
//        let presenter = CurrencyPresenter(view: view, storageService: storageService, router: router)
//        view.presenter = presenter
//
//        return view
//    }
//
//    func createColorSchemeModule(router: RouterProtocol) -> UIViewController {
//        let view = ColorThemesVC()
//        let storageService = ColorModel()
//        let presenter = ColorPresenter(view: view, storageService: storageService, router: router)
//        view.presenter = presenter
//
//        return view
//    }
//
//    func createWalletDetailsModule(router: RouterProtocol, wallet: NSManagedObject, walletIndex: IndexPath) -> UIViewController {
//        //let view = AddNewWalletVC()
//        let view = WalletDetailsVC()
//        let storageService = WalletDetailsModel()
//        let presenter = WalletDetailsPresenter(view: view, storageService: storageService, router: router, wallet: wallet, walletIndex: walletIndex)
//        view.presenter = presenter
//
//        return view
//    }
//
//    func createAddTransactionModule(router: RouterProtocol, wallet: NSManagedObject) -> UIViewController{
//        let view = AddTransactionVC()
//        let storageService = AddTransactionModel()
//        let presenter = AddTransactionPresenter(view: view, storageService: storageService, router: router, wallet: wallet)
//        view.presenter = presenter
//
//        return view
//    }
//
//    func createAllTransactionsModule(router: RouterProtocol, wallet: NSManagedObject, array: [[String]]) -> UIViewController {
//        let view = AllTransactionsVC()
//        let storageService = AllTransactionsModel()
//        let presenter = AllTransactionsPresenter(view: view, storageService: storageService, router: router, wallet: wallet, array: array)
//        view.presenter = presenter
//
//        return view
//    }
//
//    func createTransactionDetailsModule(router: RouterProtocol, wallet: NSManagedObject, array: [[String]], indexPath: IndexPath) -> UIViewController {
//        let view = TransactionDetailsVC()
//        let storageService = TransactionDetailsModel()
//        let presenter = TransactionDetailsPresenter(view: view, storageService: storageService, router: router, wallet: wallet, array: array, indexPath: indexPath)
//        view.presenter = presenter
//
//        return view
//    }
//
//    func createChangeTransactionModule(router: RouterProtocol, wallet: NSManagedObject, arrayAll: [[String]], arrayTransaction: [String], indexPath: IndexPath) -> UIViewController {
//        let view = ChangeTransactionVC()
//        let storageService = ChangeTransactionModel()
//        let presenter = ChangeTransactionPresenter(view: view, storageService: storageService, router: router, wallet: wallet, arrayAll: arrayAll, arrayTransaction: arrayTransaction, indexPath: indexPath)
//        view.presenter = presenter
//
//        return view
//    }
//
//    func createChangeWalletModule(router: RouterProtocol, wallet: NSManagedObject, walletIndex: IndexPath) -> UIViewController {
//        let view = ChangeWalletVC()
//        let storageService = ChangeWalletModel()
//        let presenter = ChangeWalletPresenter(view: view, storageService: storageService, router: router, wallet: wallet, walletIndex: walletIndex)
//        view.presenter = presenter
//
//        return view
//    }
}
