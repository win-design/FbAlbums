//
//  Photo.swift
//  Fbalbums
//
//  Created by Gms on 12/30/17.
//  Copyright © 2017 win-deisgn. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class Photo {
    
    var id: String
    var name: String
    var imageUrl: URL {
        return URL(string: "https://graph.facebook.com/\(id)/picture?access_token=\(FBSDKAccessToken.current().tokenString!)")!
    }
    
    init(id: String = "", name: String = "") {
        self.id = id
        self.name = name
    }
}

extension Photo: Equatable { }

func ==(lhs: Photo, rhs: Photo) -> Bool {
    return lhs.id == rhs.id
}

extension Photo: Hashable {
    
    var hashValue: Int {
        return Int(id) ?? 0
    }
}

