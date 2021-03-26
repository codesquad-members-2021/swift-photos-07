//
//  Doodle.swift
//  PhotosApp
//
//  Created by zombietux on 2021/03/23.
//

import Foundation

struct Doodle: Codable {
    
    private let title: String
    private let image: String
    private let date: String
    
    func getImage() -> String {
        return self.image
    }
}
