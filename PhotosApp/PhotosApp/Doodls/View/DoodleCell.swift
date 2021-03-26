//
//  DoodleCell.swift
//  PhotosApp
//
//  Created by zombietux on 2021/03/26.
//
import UIKit

class DoodleCell: UICollectionViewCell {
    static let identifier = "DoodleCell"
    
    var doodle: Doodle! {
        didSet {
            guard let imageUrl = URL(string: doodle.getImage()) else { return }
            
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
}
