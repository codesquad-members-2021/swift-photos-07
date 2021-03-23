//
//  PHAsset+ext.swift
//  PhotosApp
//
//  Created by zombietux on 2021/03/23.
//

import UIKit
import Photos

extension PHAsset {
    var image : UIImage {
        var thumbnail = UIImage()
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: self, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil, resultHandler: { image, _ in
            thumbnail = image!
        })
        return thumbnail
    }
}
