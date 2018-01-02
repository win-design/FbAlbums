//
//  PhotoViewController.swift
//  Fbalbums
//
//  Created by Gms on 12/30/17.
//  Copyright © 2017 win-deisgn. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photo = Photo()
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.sd_setImage(with: photo.imageUrl)
    }
    
    @IBAction func didClickDismissButton() {
        
        dismiss(animated: true, completion: nil)
    }
}

