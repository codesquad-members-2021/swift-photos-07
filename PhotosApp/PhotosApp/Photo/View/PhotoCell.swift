//
//  PhotoCell.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/22.
//

import UIKit
import PhotosUI

class PhotoCell: UICollectionViewCell {
    static let identifier = "PhotoCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var livePhotoImageView: PHLivePhotoView!
    @IBOutlet weak var livePhotoBadgeImageView: UIImageView!
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var isSelected: Bool {
        didSet {
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.red
            self.selectedBackgroundView = backgroundView
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        livePhotoImageView.livePhoto = nil
        livePhotoBadgeImageView.image = nil
        self.selectedBackgroundView?.transform = CGAffineTransform.identity
    }
}
