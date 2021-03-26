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
    private var photosDataSource: PhotosDataSourceManageable!
    private var photoPublisher: AnyCancellable!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.photosDataSource = PhotosDataSource()
        self.collectionView.dataSource = self.photosDataSource as? UICollectionViewDataSource
        self.collectionView.allowsMultipleSelection = true
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
        let makeVideo = UIAlertAction(title: "동영상 만들기", style: .default, handler: .none)
        let adjustEffect = UIAlertAction(title: "효과 주기", style: .default) { action in
            self.applyFilter()
        }
        let revert = UIAlertAction(title: "되돌리기", style: .default) { action in
            self.applyRevert()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        makeVideo.isEnabled = false
        adjustEffect.isEnabled = false
        revert.isEnabled = false
        
        actionSheet.addAction(makeVideo)
        actionSheet.addAction(adjustEffect)
        actionSheet.addAction(revert)
        actionSheet.addAction(cancel)
        
        self.checkEditActionActivity(makeVideo, adjustEffect, revert)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private func checkEditActionActivity(_ makeVideoAction: UIAlertAction, _ adjustEffectAction : UIAlertAction, _ revertAction: UIAlertAction) {
        guard let selectedImages = self.collectionView.indexPathsForSelectedItems else { return }
        
        if selectedImages.count == 1 && self.isFiltered() {
            revertAction.isEnabled = true
        }
        
        if selectedImages.count > 2 {
            makeVideoAction.isEnabled = true
        }
        
        if selectedImages.count >= 1 {
            adjustEffectAction.isEnabled = true
        }
    }
    
    private func applyFilter() {
        guard let selectedImages = self.collectionView.indexPathsForSelectedItems else { return }
        self.photosDataSource.adjustFilter(to: selectedImages)
    }
    
    private func applyRevert() {
        guard let selectedImages = self.collectionView.indexPathsForSelectedItems else { return }
        self.photosDataSource.revertFilter(by: selectedImages)
    }
    
    private func isFiltered() -> Bool {
        guard let selectedImages = self.collectionView.indexPathsForSelectedItems else { return false }
        return self.photosDataSource.isFiltered(selectedImages)
    }
}
