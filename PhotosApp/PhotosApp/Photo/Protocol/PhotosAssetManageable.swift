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
    func requestLivePhoto(with item: Int, completion: @escaping (PHLivePhoto?, [AnyHashable: Any]?) -> ())
    func adjustFilter(name filterName: String, to indexPaths: [IndexPath])
    func revertFilter(by indexPaths: [IndexPath])
    func isFiltered(_ indexPaths: [IndexPath]) -> Bool
    func getPhoto(at indexPath: IndexPath) -> PHAsset
}
