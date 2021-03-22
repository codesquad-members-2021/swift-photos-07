//
//  ViewController.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var photosDataSource: PhotosDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let photos = PhotosGenerator.generate()
        photosDataSource = PhotosDataSource(photos: photos)
        self.collectionView.dataSource = photosDataSource
        
    }


}
