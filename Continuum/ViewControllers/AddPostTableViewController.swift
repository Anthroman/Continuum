//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by DevMountain on 2/12/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit
import Photos

class AddPostTableViewController: UITableViewController {
  
  //MARK: - IBOutlets
  @IBOutlet weak var captionTextField: UITextField!
  
  //MARK: - Properties
  var selectedImage: UIImage?
  
  //MARK: - View Lifecycle Methods
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    captionTextField.text = nil
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toPhotoSelectorVC" {
      let photoSelector = segue.destination as? PhotoSelectorViewController
      photoSelector?.delegate = self
    }
  }
  
  //MARK: - Actions
  @IBAction func addPostButtonTapped(_ sender: UIButton) {
    guard let photo = selectedImage,
      let caption = captionTextField.text else { return }
    PostController.shared.createPostWith(photo: photo, caption: caption) { (post) in
      
    }
    addPhotoToContiuumAlbum()
    self.tabBarController?.selectedIndex = 0
  }
  
  @IBAction func cancelButtonTapped(_ sender: Any) {
    self.tabBarController?.selectedIndex = 0
  }
}

extension AddPostTableViewController: PhotoSelectorViewControllerDelegate {
  func photoSelectorViewControllerSelected(image: UIImage) {
    selectedImage = image
  }
}

//MARK: - PHPHotoLibraryChangeObserver & PhotoKit Methods
extension AddPostTableViewController: PHPhotoLibraryChangeObserver {
  func photoLibraryDidChange(_ changeInstance: PHChange) {
    print("Photo Library did Change")
  }
  
  func createContinuumAlbum(completion: @escaping (Bool) -> Void) {
    PHPhotoLibrary.shared().register(self)
    PHPhotoLibrary.shared().performChanges({
      PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: "Continuum")
    }, completionHandler: { success, error in
      completion(success)
      if !success { print("Error creating album: \(String(describing: error)).") }
    })
  }
  
  func insert(photo: UIImage, in collection: PHAssetCollection) {
    PHPhotoLibrary.shared().performChanges({
      let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: photo)
      let addAssetRequest = PHAssetCollectionChangeRequest(for: collection)
      addAssetRequest?.addAssets([creationRequest.placeholderForCreatedAsset!] as NSArray)
    }, completionHandler: nil)
  }
  
  func fetchContinuumAlbum() ->  PHAssetCollection? {
    let fetchOptions = PHFetchOptions()
    fetchOptions.predicate = NSPredicate(format: "title = %@", "Continuum")
    let assetfetchResults = PHAssetCollection.fetchAssetCollections(with: .album, subtype: PHAssetCollectionSubtype.any, options: fetchOptions)
    return assetfetchResults.firstObject
  }
  
  func addPhotoToContiuumAlbum() {
    guard let photo = selectedImage else { return }
    if let contiuumCollection = self.fetchContinuumAlbum() {
      self.insert(photo: photo, in: contiuumCollection)
    } else {
      self.createContinuumAlbum(completion: { (success) in
        guard success, let album = self.fetchContinuumAlbum() else { return }
        self.insert(photo: photo, in: album)
      })
    }
  }
}
