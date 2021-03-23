//
//  DoodlesDataSource.swift
//  PhotosApp
//
//  Created by zombietux on 2021/03/23.
//

import UIKit

class DoodlesDataSource: NSObject {
    private var doodles: [Doodle]
    
    init(doodles: [Doodle]) {
        self.doodles = doodles
    }
    
    func getDoodle(at indexPath: IndexPath) -> Doodle {
        return doodles[indexPath.item]
    }
}

extension DoodlesDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let doodle = getDoodle(at: indexPath)
        
        cell.imageView.image = UIImage(named: doodle.getImage())
        
        return cell
    }
}
