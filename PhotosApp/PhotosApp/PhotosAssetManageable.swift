//
//  PhotosAssetManageable.swift
//  PhotosApp
//
//  Created by zombietux on 2021/03/26.
//

import PhotosUI

protocol PhotosAssetManageable {
    func count() -> Int
    func requestImage(with item: Int, completion: @escaping (UIImage?, [AnyHashable: Any]?) -> ())
}
