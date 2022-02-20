//
//  AppDelegate.swift
//  OddEvenGame_Snapkit
//
//  Created by 59 on 2022/02/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // UIWindow 객체를 생성한다.
        window = UIWindow(frame: UIScreen.main.bounds)
        // View Controller와, 그 앞에 있는 Navigation Controller를 만들어준다.
        let mainVC = ViewController()
        let navigationController = UINavigationController(rootViewController: mainVC)
        // 윈도우 위에, 실제로 보여질 View를 ViewController로 설정해준다.
        window?.rootViewController = navigationController
        // 만든 윈도우를 'Key'로 만들고, 보여지도록 설정한다.
        window?.makeKeyAndVisible()

        return true
    }
}

