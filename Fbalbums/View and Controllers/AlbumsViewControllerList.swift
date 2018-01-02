//
//  AlbumsViewControllerList.swift
//  Fbalbums
//
//  Created by Gms on 12/30/17.
//  Copyright © 2017 win-deisgn. All rights reserved.
//

import UIKit

class AlbumsViewControllerList: UITableViewController {

    
    var albums = [Photo]()
    var successClosure: ((_ albums: [Photo]?) -> ())?
    // var isLoadingAlbums = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        successClosure = { [weak self] albums in
            
            if let albums = albums {
                self?.albums = albums
                self?.tableView.reloadData()
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
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let album = albums[indexPath.row]
        
        performSegue(withIdentifier: "showPhotos", sender: album)

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return albums.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album = albums[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListPhotoCell", for: indexPath) as! ListPhotoCell
        cell.descLabel.text = album.name
        cell.photo.sd_setImage(with: album.imageUrl)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    @IBAction func didClickSwitchButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}


