//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/23.
//

import UIKit

class DoodleViewController: UIViewController {

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
    }
    
    @objc func closeButtonTouched() {
        dismiss(animated: false, completion: nil)
    }
}
