//
//  PhotoCell.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/22.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    static let identifier = "PhotoCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
             super.init(frame: frame)
         }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
