//
//  ProfileVCTests.swift
//  rss.ios.stage3-final taskTests
//
//  Created by Albert Zhloba on 19.11.21.
//

import XCTest
@testable import SoundsEverywhere

class ProfileVCTests: XCTestCase {
    
    func testCanInit() throws {
        _ = try makeProfileVC()
    }
    
    func testHomeVCTitle() throws {
        let vc = try makeProfileVC()
        vc.loadViewIfNeeded()
        XCTAssertEqual(vc.title, "Profile")
    }
    
    func testConfigureCollectionView() throws {
        let vc = try makeProfileVC()
        vc.loadViewIfNeeded()
        XCTAssertNotNil(vc.tableView.dataSource, "data source")
        XCTAssertNotNil(vc.tableView.delegate, "delegate")
    }
    
    func testInitialCollectionViewState() throws {
        let vc = try makeProfileVC()
        vc.loadViewIfNeeded()
        XCTAssertEqual(vc.tableView.numberOfSections, 1)
    }
    
    func testModelState() throws {
        let vc = try makeProfileVC()
        vc.loadViewIfNeeded()
        vc.models.append("User name: name)")
        vc.models.append("Email: email")
        vc.models.append("Home page: home")
        vc.models.append("User ID: id")
        vc.models.append("Join date: date)")
        vc.models.append("Join date: date)")
        XCTAssertEqual(vc.tableView.numberOfRows(inSection: 0), 6)
    }
//    func testDataFromAPI() throws {
//        let vc = try makeHomeVC()
//        vc.loadViewIfNeeded()
//        vc.api.getLastSounds = { result in
//            switch result{
//            case .success(
//                    LastSoundsModel(count: 0, next: "1", results: [
//                        Resulter(id: 1, url: "1", name: "1", created: "1", license: "1", type: .aif, username: "1", pack: "1", download: "1", bookmark: "1", previews: Previews(previewLqOgg: "1", previewLqMp3: "1", previewHqOgg: "1", previewHqMp3: "1"), images: Images(spectralM: "1", spectralL: "1", spectralBWL: "1", waveformBWM: "1", waveformBWL: "1", waveformL: "1", waveformM: "1", spectralBWM: "1"), numDownloads: 1, durationValue: 1, avgRating: 1)
//                    ], previous: "2")
//            ): break
//            case .failure(let error):
//                print(error.localizedDescription)
//
//            }
//        }
//
//        XCTAssertEqual(vc.collectionView.numberOfSections, 2)
//    }
    
    private func makeProfileVC() throws -> ProfileVC {
        let assemblyBuilder = AssemblyModelBuilder()
        let router = RouterTabBar(assemblyBuilder: assemblyBuilder)
        let tabBar = router.passTabBar() as! TabBarVC
        tabBar.presenter.configureTabBar(view: tabBar)
        let navVC = try XCTUnwrap(tabBar.viewControllers?[2] as? UINavigationController)
        let mockVC = try XCTUnwrap(navVC.topViewController as? ProfileVC)
        //mockVC.api = APICallerStub()
        
        return mockVC
    }
    
    
}
