//
//  ViewController.swift
//  Test_Balinasoft
//
//  Created by Hleb Karpovich on 30.12.23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: 170, height: 265)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor(named: "backgroundVC")
        return collectionView
    }()
    
    var photoTypes: [Content] = []
    var layout = UICollectionViewFlowLayout()
    var currentPage = 0
    var totalPage = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoCollectionView)
        self.view.backgroundColor = UIColor(named: "backgroundVC")
        
        photoCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        getPhotoTypes()
        setupCollectionView()
    }
    
    private func getPhotoTypes() {
        Task {
            do {
                let photos = try await ApiManager.shared.getPhotoType(numberOfPage: currentPage)
                self.photoTypes = photos.content
                self.photoCollectionView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
