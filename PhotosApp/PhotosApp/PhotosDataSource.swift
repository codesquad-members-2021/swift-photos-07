//
//  PhotosDataSource.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/22.
//

import UIKit

class PhotosDataSource: NSObject {
    private let photos: [Photo]
    
    init(photos: [Photo]) {
        self.photos = photos
    }
    
    func getPhoto(at indexPath: IndexPath) -> Photo {
        return photos[indexPath.item]
    }
}

extension PhotosDataSource : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let photo = getPhoto(at: indexPath)
        
        cell.imageView.image = UIImage(named: photo.getThumbnail())
        cell.imageView.backgroundColor = UIColor.randomColor()
        
        return cell
    }
}

