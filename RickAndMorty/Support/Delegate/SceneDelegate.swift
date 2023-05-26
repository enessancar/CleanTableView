//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Enes Sancar on 25.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = RickMortyVC()
        window.backgroundColor = .systemBackground
        self.window = window
        window.makeKeyAndVisible()
    }
}

