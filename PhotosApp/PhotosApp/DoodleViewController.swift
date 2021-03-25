//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/23.
//

import UIKit

class DoodleViewController: UIViewController, ImageSaveMenuDidTapped {

    @IBOutlet weak var collectionView: UICollectionView!
    private var doodlesDataSource: DoodlesDataSource!
    private var jsonParser: JsonParser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Doodles"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeButtonTouched))
        
        jsonParser = JsonParser()
        DispatchQueue.main.async {
            self.jsonParser.parse { doodles in
                self.doodlesDataSource = DoodlesDataSource(doodles: doodles)
                self.collectionView.dataSource = self.doodlesDataSource
            }
        }
        
        configureLongPress()
    }
    
    private func configureLongPress() {
        let longPressGestureRecognizer = CustomLongPressGesture(target: self, action: #selector(imageLongPressed(sender:)))
        longPressGestureRecognizer.minimumPressDuration = 0.5
        self.view.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc func imageLongPressed(sender: CustomLongPressGesture) {
        let imagePoint = sender.location(in: self.collectionView)

        guard let indexPath = self.collectionView.indexPathForItem(at: imagePoint) else { return }
        guard let cell = self.collectionView.cellForItem(at: indexPath) as? PhotoCell else { return }
        cell.becomeFirstResponder()
        sender.imageView = cell.imageView
        
        let saveItem = UIMenuItem(title: "Save", action: #selector(saveItemTapped))
        UIMenuController.shared.menuItems = [saveItem]
        UIMenuController.shared.arrowDirection = .default
        UIMenuController.shared.showMenu(from: self.collectionView, rect: CGRect(origin: imagePoint, size: CGSize(width: 100, height: 100)))
    }
    
    @objc func saveItemTapped(sender: CustomLongPressGesture) {
    }
    
    @objc func closeButtonTouched() {
        dismiss(animated: false, completion: nil)
    }
    
    func save(imageView: UIImageView) {
    }
}

class CustomLongPressGesture: UILongPressGestureRecognizer {
    var imageView: UIImageView?
}
