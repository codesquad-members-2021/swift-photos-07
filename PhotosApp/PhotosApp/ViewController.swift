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
