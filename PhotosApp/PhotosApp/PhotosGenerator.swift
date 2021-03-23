//
//  PhotosGenerator.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/22.
//

import Foundation

class PhotosGenerator {
    
    class func generate() -> [Photo] {
        
        var photoList = [Photo]()
        
        for _ in 0..<40 {
            photoList.append(Photo(thumbnail: ""))
        }
        
        return photoList
    }
}
