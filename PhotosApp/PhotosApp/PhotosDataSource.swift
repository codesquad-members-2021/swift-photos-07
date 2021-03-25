//
//  PhotosDataSource.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/22.
//

import UIKit
import Photos

class PhotosDataSource: NSObject {
    private var photosAsset: PhotosAssetManageable
    
    override init() {
        self.photosAsset = PhotosAsset()
        super.init()
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
        
        let resultHandler = { (image: UIImage?, _: [AnyHashable: Any]?) -> () in
            cell.imageView.image = image
        }
        photosAsset.requestImage(with: indexPath.item, completion: resultHandler)
        
        return cell
    }
}

