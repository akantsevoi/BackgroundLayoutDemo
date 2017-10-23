//
//  AppDelegate.swift
//  CollectionViewLoadTest
//
//  Created by Sasha K on 10/14/17.
//  Copyright © 2017 Aliaksandr Kantsevoi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var service: TestService?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let controller = ViewController()

        let service = TestService()
        self.service = service
        let layoutHelper = LayoutHelper(serviceModels: service.signal)

        let rootController = RootViewController(
            workController: controller,
            layoutHelper: layoutHelper)

        window = UIWindow(frame : UIScreen.main.bounds)
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()

        return true
    }
}

