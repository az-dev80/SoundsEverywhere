//
//  CategoryVCTests.swift
//  rss.ios.stage3-final taskTests
//
//  Created by Albert Zhloba on 19.11.21.
//

import XCTest
@testable import SoundsEverywhere

class CategoryVCTests: XCTestCase {
    
    func testCanInit() throws {
        _ = try makeCategoryVC()
    }
    
    func testHomeVCTitle() throws {
        let vc = try makeCategoryVC()
        vc.loadViewIfNeeded()
        XCTAssertEqual(vc.title, "Xxx")
    }
    
    func testConfigureCollectionView() throws {
        let vc = try makeCategoryVC()
        vc.loadViewIfNeeded()
        XCTAssertNotNil(vc.collectionView.dataSource, "data source")
        XCTAssertNotNil(vc.collectionView.delegate, "delegate")
    }
    
    func testInitialCollectionViewState() throws {
        let vc = try makeCategoryVC()
        vc.loadViewIfNeeded()
        XCTAssertEqual(vc.collectionView.numberOfSections, 1)
    }
    
    
    private func makeCategoryVC() throws -> CategoryVC {
        let assemblyBuilder = AssemblyModelBuilder()
        let router = RouterTabBar(assemblyBuilder: assemblyBuilder)
        let tabBar = router.passTabBar() as! TabBarVC
        tabBar.presenter.configureTabBar(view: tabBar)
        let navVC = try XCTUnwrap(tabBar.viewControllers?[1] as? UINavigationController)
        navVC.pushViewController(CategoryVC(category: "xxx", index: 0), animated: false)
        let mockVC = try XCTUnwrap(navVC.topViewController as? CategoryVC)
        //mockVC.api = APICallerStub()
        
        return mockVC
    }
    
    
}
