//
//  FacebookServices.swift
//  Fbalbums
//
//  Created by Gms on 12/30/17.
//  Copyright © 2017 win-deisgn. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

struct FacebookServices {
    
    func login(onLoginFinished: ((_ token: String?) -> ())?) {
        
        let loginManager = LoginManager(loginBehavior: .native)
        
        loginManager.logIn(readPermissions: [.userPhotos]) { result in
            
            switch result {
            case .failed(_):
                onLoginFinished?(nil)
            case .cancelled:
                onLoginFinished?(nil)
            case .success(_, _, let token):
                onLoginFinished?(token.authenticationToken)
            }
            
        }
    }
    
}

