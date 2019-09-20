//
//  AppDelegate.swift
//  MyRealPet
//
//  Created by KimSeulWoo on 19/09/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        LibrariesManager.shared.setupLibs()
        
        let rootVC = PetListViewController(viewModel: PetListViewModel())
        let navVC = NavigationController(rootViewController: rootVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

}

