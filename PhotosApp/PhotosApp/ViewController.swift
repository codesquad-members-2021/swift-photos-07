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
        self.collectionView.allowsMultipleSelection = true
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
    
    @IBAction func EditButtonPressed(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        let makeVideo = UIAlertAction(title: "동영상 만들기", style: .default, handler: alertActionHandler)
        let makeEffect = UIAlertAction(title: "효과 주기", style: .default, handler: nil)
        let revert = UIAlertAction(title: "되돌리기", style: .default, handler: nil)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheet.addAction(makeVideo)
        actionSheet.addAction(makeEffect)
        actionSheet.addAction(revert)
        actionSheet.addAction(cancel)
        
        // 사진 선택하면 isEnabled = true 로 변경하기!
//        makeVideo.isEnabled = false
        makeEffect.isEnabled = false
        revert.isEnabled = false
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func alertActionHandler(_ sender: UIAlertAction) {
        print(sender.title ?? "안 찍힘;;")
        
        let alert = UIAlertController(title: "Allow \"PhotosApp\" to modify this photo?", message: .none, preferredStyle: .alert)
//        alert.setValue(UIImage(, forKey: <#T##String#>)
        
        let no = UIAlertAction(title: "Don't Allow", style: .default, handler: nil)
        let yes = UIAlertAction(title: "Modify", style: .default, handler: nil)
        
        alert.addAction(no)
        alert.addAction(yes)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
