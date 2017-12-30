//
//  FirebaseServices.swift
//  Fbalbums
//
//  Created by Gms on 12/30/17.
//  Copyright © 2017 win-deisgn. All rights reserved.
//

import Firebase

struct FirebaseServices {
    
    func uploadPhotos(_ photos: [Photo], uploadCompletion: ((Bool) -> ())?) {
        
        var uploadedPhotosCount = 0
        
        for photo in photos {
            
            let data = try? Data(contentsOf: photo.imageUrl)
            
            guard let photoData = data else { return }
            
            let storageRef = Storage.storage().reference().child("images/\(photo.id).jpg")
            storageRef.putData(photoData, metadata: nil, completion: { metadata, error in
                
                if error != nil {
                    
                    uploadCompletion?(false)
                    return
                } else {
                    
                    uploadedPhotosCount += 1
                    if photos.count == uploadedPhotosCount {
                        uploadCompletion?(true)
                        return
                    }
                    
                }
                
            })
            
        }
    }
}
