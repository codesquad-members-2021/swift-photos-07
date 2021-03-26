//
//  PhotosDataSource.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/22.
//

import UIKit
import Photos
import PhotosUI

class PhotosDataSource: NSObject {
    
    private var photo: PHAsset!
    private var photos = PHAsset.fetchAssets(with: .none)
    private let cachingManager = PHCachingImageManager()
    
    override init() {
        super.init()
        
        PHPhotoLibrary.shared().register(self)
    }
    
    func getPhotos() -> PHFetchResult<PHAsset> {
        return self.photos
    }
}

extension PhotosDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        self.photo = photos.object(at: indexPath.item)
        
        // MARK: image display
        if photo.mediaSubtypes.contains(.photoLive) {
            updateLivePhoto(cell: cell)
        } else {
            updateStaticPhoto(cell: cell)
        }
        return cell
    }
    
    private func updateStaticPhoto(cell: PhotoCell) {
        let resultHandler = { (image: UIImage?, _: [AnyHashable: Any]?) -> () in
            
            // Show the image.
            cell.livePhotoImageView.isHidden = true
            cell.imageView.isHidden = false
            cell.imageView.image = image
        }
        
        cachingManager.requestImage(for: photo,
                                    targetSize: CGSize(width: Photo.Size.width, height: Photo.Size.height),
                                    contentMode: .aspectFill,
                                    options: .none,
                                    resultHandler: resultHandler)
    }
    
    private func updateLivePhoto(cell: PhotoCell) {
        
        let resultHandler = { (livePhoto: PHLivePhoto?, _:[AnyHashable : Any]?) in
            // Show the Live Photo view.
            guard let livePhoto = livePhoto else { return }
            
            // Show the Live Photo.
            cell.imageView.isHidden = true
            cell.livePhotoImageView.isHidden = false
            cell.livePhotoImageView.livePhoto = livePhoto
            cell.livePhotoBadgeImageView.image = PHLivePhotoView.livePhotoBadgeImage(options: .overContent)
            
        }
        
        // Request the live photo for the asset from the default PHImageManager.
        PHImageManager.default().requestLivePhoto(for: photo,
                                                  targetSize: CGSize(width: Photo.Size.width, height: Photo.Size.height),
                                                  contentMode: .aspectFit,
                                                  options: .none,
                                                  resultHandler: resultHandler)
    }
    
}


//MARK:- PHPhotoLibraryChangeObserver

extension PhotosDataSource: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changedPhotos = changeInstance.changeDetails(for: photos) else { return }
        self.photos = changedPhotos.fetchResultAfterChanges
        NotificationCenter.default.post(name: Photo.NotificationName.didChangePhotos, object: self)
    }
}
