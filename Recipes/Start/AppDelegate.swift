//
//  AppDelegate.swift
//  Recipes
//
//  Created by Apple on 10/14/20.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
   


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupDI()
        return true
    }
    
    func setupDI(){
        // DI
        
            // Model
        DI.container.register(RecipeRepositoryType.self) { r -> RecipeRepositoryType in
                return RecipeRepository()
            }.inObjectScope(.container)
            
            
            // ViewModel
        DI.container.register(RecipesViewModel.self) { r in
                return RecipesViewModel()
            }
            
            let storyboard = UIStoryboard(name: "Recipe", bundle: nil)
        DI.container.register(RecipesNavigationViewType.self) { r -> RecipesNavigationViewType in
                return storyboard.instantiateViewController(withIdentifier: "Route")
            }
            
        DI.container.register(RecipesViewControllerType.self) { r -> RecipesViewControllerType in
                return storyboard.instantiateViewController(withIdentifier: "Home")
            }
        
        DI.container.register(RecipesAddViewControllerType.self) { r -> RecipesAddViewControllerType in
                return storyboard.instantiateViewController(withIdentifier: "Add")
            }
            
         
            
        
        
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

