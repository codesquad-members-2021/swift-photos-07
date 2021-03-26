//
//  PhotosDataSource.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/22.
//

import UIKit
import Photos
import PhotosUI

class PhotosDataSource: NSObject, PhotosDataSourceManageable {
    private var photosAsset: PhotosAssetManageable

    override init() {
        self.photosAsset = PhotosAsset()
        super.init()
    }
    
    func adjustFilter(to indexPaths: [IndexPath]) {
        self.photosAsset.adjustFilter(name: "CIBloom", to: indexPaths)
    }
    
    func revertFilter(by indexPaths: [IndexPath]) {
        self.photosAsset.revertFilter(by: indexPaths)
    }
    
    func isFiltered(_ indexPaths: [IndexPath]) -> Bool {
        return self.photosAsset.isFiltered(indexPaths)
    }
}

extension PhotosDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosAsset.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        // MARK: image display
        if photosAsset.getPhoto(at: indexPath).mediaSubtypes.contains(.photoLive) {
            updateLivePhoto(cell: cell, at: indexPath)
        } else {
            updateStaticPhoto(cell: cell, at: indexPath)
        }
        return cell
    }
    
    private func updateStaticPhoto(cell: PhotoCell, at indexPath: IndexPath) {
        let resultHandler = { (image: UIImage?, _: [AnyHashable: Any]?) -> () in
            // Show the image.
            cell.livePhotoImageView.isHidden = true
            cell.imageView.isHidden = false
            cell.imageView.image = image
        }
        photosAsset.requestImage(with: indexPath.item, completion: resultHandler)
    }
    
    private func updateLivePhoto(cell: PhotoCell, at indexPath: IndexPath) {
        let resultHandler = { (livePhoto: PHLivePhoto?, _:[AnyHashable : Any]?) in
            // Show the Live Photo view.
            guard let livePhoto = livePhoto else { return }

            // Show the Live Photo.
            cell.imageView.isHidden = true
            cell.livePhotoImageView.isHidden = false
            cell.livePhotoImageView.livePhoto = livePhoto
            cell.livePhotoBadgeImageView.image = PHLivePhotoView.livePhotoBadgeImage(options: .overContent)            
        }
        photosAsset.requestLivePhoto(with: indexPath.item, completion: resultHandler)
    }
    
}
