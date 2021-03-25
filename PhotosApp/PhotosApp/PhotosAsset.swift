//
//  PhotosAsset.swift
//  PhotosApp
//
//  Created by zombietux on 2021/03/26.
//

import Foundation
import Photos
import PhotosUI

class PhotosAsset: NSObject, PhotosAssetManageable {
    private var photos = PHAsset.fetchAssets(with: .none)
    private let cachingManager = PHCachingImageManager()
    
    override init() {
        super.init()
        PHPhotoLibrary.shared().register(self)
    }
    
    func count() -> Int {
        return photos.count
    }
    
    func requestImage(with item: Int, completion: @escaping (UIImage?, [AnyHashable: Any]?) -> ()) {
        let photo = photos.object(at: item)
        cachingManager.requestImage(for: photo,
                                  targetSize: CGSize(width: Photo.Size.width, height: Photo.Size.height),
                                  contentMode: .aspectFill,
                                  options: nil,
                                  resultHandler: completion)
    }
}

extension PhotosAsset: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changedPhotos = changeInstance.changeDetails(for: self.photos) else { return }
        self.photos = changedPhotos.fetchResultAfterChanges
        NotificationCenter.default.post(name: Photo.NotificationName.didChangePhotos, object: self)
    }
}
