//
//  ViewController.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/22.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var photosDataSource: PhotosDataSource!
    private var photoPublisher: AnyCancellable!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photosDataSource = PhotosDataSource()
        self.collectionView.dataSource = photosDataSource
        setPhotosSubscriber()
    }
    
    private func setPhotosSubscriber() {
        photoPublisher = NotificationCenter.default
            .publisher(for: Photo.NotificationName.didChangePhotos)
            .sink { notification in
                DispatchQueue.main.async {
                    self.updateCollectionView()
                }
            }
    }
    
    private func updateCollectionView() {
        self.collectionView.reloadData()
    }
    
    private func pushView() {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "DoodleViewController") as! DoodleViewController
        
        let navController = UINavigationController(rootViewController: pushVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
     }

    @IBAction func addButton(_ sender: Any) {
        pushView()
    }
}
