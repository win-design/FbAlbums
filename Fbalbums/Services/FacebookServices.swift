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
    
    func getAlbums(success: @escaping (_ albums: [Photo]?) -> ()) {
        
        
        GraphRequest(graphPath: "/me", parameters: ["fields" : "albums"])
            .start({ response, result in
                
                switch result {
                case .success(let response):
                    print(response)
                    
                    if let parsedData = response.dictionaryValue {
                        
                        let albumsDictionary = (parsedData["albums"]! as! [String : Any])["data"] as! [[String : Any]]
                        
                        var albums = [Photo]()
                        
                        for albumDictionary in albumsDictionary {
                            
                            let album = Photo(id: albumDictionary["id"] as! String, name: albumDictionary["name"] as! String)
                            albums.append(album)
                        }
                        
                        success(albums)
                        print(parsedData)
                    }
                    
                default: break
                }
                
            })
        success(nil)
    }
    
    func getPhotos(albumId: String, success: @escaping (_ albums: [Photo]?) -> ()) {
        
        
        GraphRequest(graphPath: "/\(albumId)/photos")
            .start({ response, result in
                
                switch result {
                case .success(let response):
                    print(response)
                    
                    if let parsedData = response.dictionaryValue {
                        
                        let photosDictionay = parsedData["data"]! as! [[String : Any]]
                        
                        var photos = [Photo]()
                        
                        for photoDictionay in photosDictionay {
                            
                            let photo = Photo(id: photoDictionay["id"] as! String)
                            photos.append(photo)
                        }
                        
                        success(photos)
                    }
                    
                default: break
                }
                
            })
        success(nil)
    }
    
}
