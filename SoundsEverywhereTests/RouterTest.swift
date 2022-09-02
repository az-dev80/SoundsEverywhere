//
//  RouterTest.swift
//  rss.ios.stage3-final taskTests
//
//  Created by Albert Zhloba on 18.11.21.
//

import XCTest
//import CoreData
@testable import SoundsEverywhere

//class MockVC: UITabBarController {
//    var presentedVC:UITabBarController?
//
//    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
//        presentedVC = viewControllerToPresent
//        super.present(viewControllerToPresent, animated: false, completion: nil)
//    }
//
//}

class RouterTest: XCTestCase {

    var router: RouterTabBarProtocol!
    //var vc = MockVC()
    var assembly = AssemblyModelBuilder()
    
    override func setUpWithError() throws {
        router = RouterTabBar(assemblyBuilder: assembly)
    }

    override func tearDownWithError() throws {
        router = nil
    }
    
    func testRouter(){
        let tabBarVC = router.passTabBar()
        XCTAssertTrue(tabBarVC is TabBarVC)
    }
}
