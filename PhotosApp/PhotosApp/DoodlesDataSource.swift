//
//  DoodlesDataSource.swift
//  PhotosApp
//
//  Created by zombietux on 2021/03/23.
//

import UIKit

protocol ImageSaveMenuDidTapped {
    func save(imageView: UIImageView)
}

class DoodlesDataSource: NSObject {
    private var doodles: [Doodle]
    private var delegate: ImageSaveMenuDidTapped?
    
    init(doodles: [Doodle]) {
        self.doodles = doodles
    }
    
    private func getDoodle(at indexPath: IndexPath) -> Doodle {
        return doodles[indexPath.item]
    }
}

extension DoodlesDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        let doodle = getDoodle(at: indexPath)
        guard let imageUrl = URL(string: doodle.getImage()) else { return UICollectionViewCell() }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data)
                }
            }
        }
    
        return cell
    }
}
