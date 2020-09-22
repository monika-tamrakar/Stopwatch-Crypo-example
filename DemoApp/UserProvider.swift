//
//  UserProvider.swift
//  DemoApp
//
//  Created by Monika on 22/09/20.
//

import Foundation
import GoogleSignIn

class UserProvider {
    
    public static let shared = UserProvider()
    
    public static let USER_LOGGED_IN = "UserLoggedIn"
    
    private var window: UIWindow?
    
    private init() {}
    
    public func configure(_ window: UIWindow?) {
        self.window = window
        GIDSignIn.sharedInstance().clientID = "302990214270-s09e2uie7mdulehnbnpghulpb8qura69.apps.googleusercontent.com"
    }
    
    public var user: User? {
        do {
            if let dictValue = UserDefaults.standard.object(forKey: Self.USER_LOGGED_IN) as? [String: Any] {
                let json = try JSONSerialization.data(withJSONObject: dictValue)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(User.self, from: json)
            } else {
                return nil
            }
        } catch {
            print(error)
            return nil
        }
    }

    public func launch() {
        if self.window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        let navVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "landingNavVC") as! UINavigationController
        if user == nil {
            navVC.viewControllers = [UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")]
        } else {
            navVC.viewControllers = [UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashboardVC")]
        }
        
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
    }
    
}

struct User : Codable {
    var userId: String?
    var idToken: String?
    var name: String?
    var email: String?
}

