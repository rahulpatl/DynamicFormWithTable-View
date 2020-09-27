//
//  AppDelegate.swift
//  FormWithTableView
//
//  Created by Rahul Patil on 27/09/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    window = UIWindow()
    setRootVC()
    return true
  }
  
  func setRootVC() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
    let nc = UINavigationController(rootViewController: vc!)
    window?.rootViewController = nc
    window?.makeKeyAndVisible()
  }

}

