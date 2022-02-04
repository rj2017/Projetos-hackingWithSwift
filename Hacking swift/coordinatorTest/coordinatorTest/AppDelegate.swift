//
//  AppDelegate.swift
//  coordinatorTest
//
//  Created by Raphael de Jesus on 18/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var window: UIWindow?
        let navc = UINavigationController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navc
    // Initialise the first coordinator with the main navigation controller
        // The start method will actually display the main view
        let vc: ViewController = ViewController()
        navc.viewControllers = [vc]
//        navc.pushViewController(vc, animated: true)
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

