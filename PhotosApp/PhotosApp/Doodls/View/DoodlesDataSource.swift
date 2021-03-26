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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoodleCell.identifier, for: indexPath) as? DoodleCell else { return UICollectionViewCell() }
        let doodle = getDoodle(at: indexPath)
        cell.doodle = doodle
        
        return cell
    }
}
