//
//  ViewController.swift
//  DemoApp
//
//  Created by Monika on 22/09/20.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
   
    @IBOutlet weak var googleSignInView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        
        let googleSigninBtn = GIDSignInButton()
        googleSigninBtn.addTarget(self, action: #selector(btnSignIn(_:)), for: .touchUpInside)
        googleSignInView.addSubview(googleSigninBtn)
    }

    @objc func btnSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}

extension ViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
              print("The user has not signed in before or they have since signed out.")
            } else {
              print("\(error.localizedDescription)")
            }
            return
          }
          
        
        let loogedInUser = ["userId": user.userID, "idToken": user.authentication.idToken, "name": user.profile.name, "email": user.profile.email]
        UserDefaults.standard.setValue(loogedInUser, forKey: UserProvider.USER_LOGGED_IN)
        UserProvider.shared.launch()
    }
    
    
}
