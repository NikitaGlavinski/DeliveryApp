//
//  SceneDelegate.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import UIKit
import FBSDKCoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = .init(windowScene: windowScene)
        
        var rootViewController: UIViewController
        let secureStorage: SecureStorageService = .init()
        if let _ = secureStorage.obtainOnboardingFlag() {
            if let _ = secureStorage.obtainToken() {
                let homeNavigation: UINavigationController = .init(rootViewController: HomeAssembly.assemble())
                let searchNavigation: UINavigationController = .init(rootViewController: SearchAssembly.assemble())
                searchNavigation.navigationBar.isHidden = true
                let orderNavigation: UINavigationController = .init(rootViewController: OrderAssembly.assemble())
                orderNavigation.navigationBar.isHidden = true
                let profileNavigation: UINavigationController = .init(rootViewController: ProfileAssembly.assemble())
                profileNavigation.navigationBar.isHidden = true
                let tabBarController: UITabBarController = .init()
                tabBarController.tabBar.tintColor = UIColor(red: 34/255, green: 164/255, blue: 97/255, alpha: 1)
                tabBarController.setViewControllers([homeNavigation, searchNavigation, orderNavigation, profileNavigation], animated: true)
                rootViewController = tabBarController
            } else {
                rootViewController = LoginAssembly.assemble()
            }
        } else {
            rootViewController = OnboardingAssembly.assemble()
        }
        let navigationController: UINavigationController = .init(rootViewController: rootViewController)
        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: [UIApplication.OpenURLOptionsKey.annotation])
    }
    
    private func setupWithToken() {
        
    }


}

