//
//  SceneDelegate.swift
//  Parnaso
//
//  Created by aaav on 12/11/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let nav = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
    }

}

