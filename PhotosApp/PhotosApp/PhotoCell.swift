//
//  PhotoCell.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/22.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func saveDoodleImage() {
        
    }
}
