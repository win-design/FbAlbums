//
//  PhotosViewController.swift
//  Fbalbums
//
//  Created by Gms on 12/30/17.
//  Copyright © 2017 win-deisgn. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var onUploadComplition: ((Bool) -> ())?
    
    var selectionModeActivated = false
    var album = Photo()
    var photos = [Photo]()
    var selectedPhotos = [Photo]() {
        didSet {
            collectionView.visibleSupplementaryViews(ofKind: UICollectionElementKindSectionFooter).first?.isHidden = selectedPhotos.count <= 0
        }
    }
    var successClosure: ((_ albums: [Photo]?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        successClosure = { [weak self] photos in
            
            if let photos = photos {
                self?.photos = photos
                self?.collectionView.reloadData()
            }
        }
        
        FacebookServices().getPhotos(albumId: album.id,success: successClosure!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "presentPhoto" {
            
            let navController = segue.destination as! UINavigationController
            let photoViewController = navController.topViewController as! PhotoViewController
            photoViewController.photo = sender as! Photo
        }
    }
    
    @IBAction func didClickRightBarButton(_ sender: Any) {
        
        if selectionModeActivated {
            rightBarButton.title = "Select"
            selectedPhotos.removeAll()
            collectionView.reloadData()
        } else {
            rightBarButton.title = "Cancel"
        }
        
        selectionModeActivated = !selectionModeActivated
    }
    
// Click button here
    
}

extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photo = photos[indexPath.row]
        
        if selectionModeActivated {
            if let photoIndex = selectedPhotos.index(of: photo) {
                selectedPhotos.remove(at: photoIndex)
            } else {
                selectedPhotos.append(photo)
            }
            
            collectionView.reloadData()
        } else {
            
            performSegue(withIdentifier: "presentPhoto", sender: photo)
        }
    }
    
    
}

extension PhotosViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let photo = photos[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.photo.sd_setImage(with: photo.imageUrl)
        cell.selectionOverlayView.isHidden = !selectedPhotos.contains(photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            return footer
        }
        return UICollectionReusableView()
    }
}
