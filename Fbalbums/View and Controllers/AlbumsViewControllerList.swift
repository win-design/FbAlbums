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
    // partie fun for loding albumes
    
    func loadFirstAlbums() {
        //isLoadingAlbums = true
//        StarWarsSpecies.getSpecies { result in
//            if let error = result.error {
//                // TODO: improved error handling
//                self.isLoadingAlbums = false
//                let alert = UIAlertController(title: "Error", message: "Could not load first species :( \(error.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
//                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//            let speciesWrapper = result.value
//           // self.addSpeciesFromWrapper(speciesWrapper)
//            self.isLoadingAlbums = false
//            self.tableview?.reloadData()
//        }
    }
    // loding seconde
    func loadMoreAlbums() {
//        self.isLoadingSpecies = true
//        if let species = self.species,
//            let wrapper = self.speciesWrapper,
//            let totalSpeciesCount = wrapper.count,
//            species.count < totalSpeciesCount {
//            // there are more species out there!
//            StarWarsSpecies.getMoreSpecies(speciesWrapper) { result in
//                if let error = result.error {
//                    self.isLoadingSpecies = false
//                    let alert = UIAlertController(title: "Error", message: "Could not load more species :( \(error.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
//                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//                }
//                let moreWrapper = result.value
//                self.addSpeciesFromWrapper(moreWrapper)
//                self.isLoadingSpecies = false
//                self.tableview?.reloadData()
//            }
//        }
        
    }
    //

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return albums.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album = albums[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListPhotoCell", for: indexPath) as! ListPhotoCell
        cell.descLabel.text = album.name
        cell.photo.sd_setImage(with: album.imageUrl)
        // See if we need to load more species
        /*
        let rowsToLoadFromBottom = 5;
        let rowsLoaded = albums.count
        if (!self.isLoadingAlbums && (indexPath.row >= (rowsLoaded - rowsToLoadFromBottom))) {
            //let totalRows = self.speciesWrapper?.count ?? 0
            let remainingSpeciesToLoad = totalRows - rowsLoaded;
            if (remainingSpeciesToLoad > 0) {
                self.loadMoreAlbums()
            }
 */
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    @IBAction func didClickSwitchButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}


