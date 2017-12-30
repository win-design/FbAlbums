//
//  AlbumsViewController.swift
//  Fbalbums
//
//  Created by Gms on 12/30/17.
//  Copyright © 2017 win-deisgn. All rights reserved.
//

import UIKit
import SDWebImage

class AlbumsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var albums = [Photo]()
    var successClosure: ((_ albums: [Photo]?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        successClosure = { [weak self] albums in
            
            if let albums = albums {
                self?.albums = albums
                self?.collectionView.reloadData()
            }
        }
        
        FacebookServices().getAlbums(success: successClosure!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPhotos" {
            let photosViewController = segue.destination as! PhotosViewController
            photosViewController.album = sender as! Photo
        }
    }

}

extension AlbumsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let album = albums[indexPath.row]
        
        performSegue(withIdentifier: "showPhotos", sender: album)
    }
}

extension AlbumsViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let album = albums[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.descLabel.text = album.name
        cell.photo.sd_setImage(with: album.imageUrl)
        return cell
    }
}

