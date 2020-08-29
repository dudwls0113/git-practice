//
//  AppDelegate.swift
//  ios
//
//  Created by Jerry Jung on 06/08/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import CoreData
//import AlamofireNetworkActivityIndicator
import Alamofire
import Firebase
import GoogleSignIn
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // Production 서버
//    let baseUrl = "https://beluv.softsquared.com"
    // Dev 서버
    static let baseUrl = "http://3.14.214.27"
    static let firebaseUrl = "medium-softsquared.firebaseapp.com"
    static let jwt = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJkYXRlIjoiMjAxOS0xMC0xMiAxNjo0NzoxNCIsInVzZXJJZCI6IjcifQ.7Wbjxx71vahTAUR7MEb76CWJNQktnV6s8nF4AVj1g7g"
    static let headers = HTTPHeaders(dictionaryLiteral: ("x-access-token", "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJkYXRlIjoiMjAxOS0xMC0xMiAxNjo0NzoxNCIsInVzZXJJZCI6IjcifQ.7Wbjxx71vahTAUR7MEb76CWJNQktnV6s8nF4AVj1g7g"))

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // StatusBar에 Alamofire 시도 중 Indicator 띄워주기 위한 옵션 설정
        // NetworkActivityIndicatorManager.shared.isEnabled = true
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        FBLoginButton().delegate = self
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        let signUpView = UINavigationController(rootViewController: LoginWireframe.createSignUpModule() as BaseViewController)
        let mediumViewController = TabBarController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = (Auth.auth().currentUser == nil) ? signUpView : mediumViewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // Google SignIn
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey:Any])
      -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ios")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
//        UserDefaults.standard.set("google", forKey: "login")
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
//        UserDefaults.standard.set(nil, forKey: "login")
    }
}

extension AppDelegate: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        //
    }
}
