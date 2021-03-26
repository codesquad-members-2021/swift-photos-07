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
        configureDataSource()
        configureLongPress()
    }
    
    private func configureDataSource() {
        DispatchQueue.main.async {
            self.jsonParser.parse { doodles in
                self.doodlesDataSource = DoodlesDataSource(doodles: doodles)
                self.collectionView.dataSource = self.doodlesDataSource
            }
        }
    }
    
    private func configureLongPress() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(imageLongPressed(sender:)))
        longPressGestureRecognizer.minimumPressDuration = 0.5
        self.view.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc func imageLongPressed(sender: UILongPressGestureRecognizer) {
        let imagePoint = sender.location(in: self.collectionView)

        guard let indexPath = self.collectionView.indexPathForItem(at: imagePoint) else { return }
        guard let cell = self.collectionView.cellForItem(at: indexPath) as? PhotoCell else { return }
        cell.becomeFirstResponder()
        CustomUIMenuController.imageView = cell.imageView
        
        let saveItem = UIMenuItem(title: "Save", action: #selector(saveItemTapped))
        UIMenuController.shared.menuItems = [saveItem]
        UIMenuController.shared.arrowDirection = .default
        UIMenuController.shared.showMenu(from: self.collectionView, rect: CGRect(origin: sender.location(in: self.collectionView), size: CGSize(width: 100, height: 100)))
    }
    
    @objc func saveItemTapped() {
        save(imageView: CustomUIMenuController.imageView ?? UIImageView())
    }
    
    @objc func closeButtonTouched() {
        dismiss(animated: false, completion: nil)
    }
    
    func save(imageView: UIImageView) {
        guard let image = imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, .none, .none, .none)
    }
}

// #selector 매개변수 전달을 위한 custom class
class CustomUIMenuController: UIMenuController {
    static var imageView: UIImageView?
}
