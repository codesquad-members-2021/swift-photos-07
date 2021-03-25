//
//  ViewController.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/22.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var photosDataSource: PhotosDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photosDataSource = PhotosDataSource()
        self.collectionView.dataSource = photosDataSource
        PHPhotoLibrary.shared().register(self)
    }
    
    func pushView() {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "DoodleViewController") as! DoodleViewController
        
        let navController = UINavigationController(rootViewController: pushVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
     }

    @IBAction func addButton(_ sender: Any) {
        pushView()
    }
}

extension ViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        // 변경됨
    }
}
