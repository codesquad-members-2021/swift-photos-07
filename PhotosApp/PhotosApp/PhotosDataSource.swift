//
//  PhotosDataSource.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/22.
//

import UIKit
import Photos

class PhotosDataSource: NSObject {
    private let photos = PHAsset.fetchAssets(with: .none)
    private let cachingManager = PHCachingImageManager()
    
}

extension PhotosDataSource : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        let photo = photos.object(at: indexPath.item)
        let resultHandler = { (image: UIImage?, _: [AnyHashable: Any]?) -> () in
            cell.imageView.image = image
        }
        cachingManager.requestImage(for: photo,
                                    targetSize: CGSize(width: Photo.Size.width, height: Photo.Size.height),
                                    contentMode: .aspectFill,
                                    options: .none,
                                    resultHandler: resultHandler)
        return cell
    }
}

