//
//  SceneDelegate.swift
//  Descope-Swift-Sample-App
//
//  Created by Descope 2023
//

import UIKit
import SwiftUI
import DescopeKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        //Descope.projectId = ""
        let localProjectId = Bundle.main.infoDictionary!["myProjectId"] as! String
        let localBaseURL = Bundle.main.infoDictionary!["myBaseURL"] as! String
        Descope.config = DescopeConfig(projectId: localProjectId, baseURL: localBaseURL)
    
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")


        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let contentView = ContentView().environment(\.managedObjectContext, context)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

