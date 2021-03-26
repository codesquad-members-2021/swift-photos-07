//
//  Photo.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/22.
//

import Foundation

struct Photo {
    enum NotificationName {
        static let didChangePhotos = Notification.Name("didChangePhotos")
    }
    
    enum Size {
        static let width = 100
        static let height = 100
    }
    
    private var thumbnail: String = ""
    
    func getThumbnail() -> String {
        return self.thumbnail
    }
}

