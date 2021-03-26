//
//  PhotosDataSourceManageable.swift
//  PhotosApp
//
//  Created by zombietux on 2021/03/26.
//

import Foundation

protocol PhotosDataSourceManageable {
    func adjustFilter(to indexPaths: [IndexPath])
    func revertFilter(by indexPaths: [IndexPath])
    func isFiltered(_ indexPaths: [IndexPath]) -> Bool
}
