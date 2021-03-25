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
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func saveDoodleImage() {
        
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                print("👍🏻")
                
                let backgroundView = UIView()
                backgroundView.backgroundColor = UIColor.red
                self.selectedBackgroundView = backgroundView
                
                self.imageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                self.imageView.alpha = 1
            } else {
                self.selectedBackgroundView?.backgroundColor = UIColor.blue
                self.imageView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                print("else")
            }
        }
    }
}
