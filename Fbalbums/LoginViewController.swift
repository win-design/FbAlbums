//
//  LoginViewController.swift
//  Fbalbums
//
//  Created by Gms on 12/30/17.
//  Copyright © 2017 win-deisgn. All rights reserved.
//

import UIKit

import UIKit

class LoginViewController: UIViewController {
    
    var onLoginFinished: ((_ token: String?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didClickLoginButton() {
        
        onLoginFinished = { [weak self] token in
            
            if let _ = token {
                self?.performSegue(withIdentifier: "showAlbums", sender: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Login Failed", preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "Ok", style: .`default`, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        }
        FacebookServices().login(onLoginFinished: onLoginFinished)
    }
    
}

