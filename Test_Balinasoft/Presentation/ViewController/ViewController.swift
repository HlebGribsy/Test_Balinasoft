//
//  ViewController.swift
//  Test_Balinasoft
//
//  Created by Hleb Karpovich on 30.12.23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private(set) var contentView = ViewControllerView()
    
    override func loadView() {
        view = contentView
    }
    
    var photoTypes: [Content] = []
    var typeId: Int?
    var currentPage = 0
    var totalPage = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainBackground
        
        getPhotoTypes()
        setupCollectionView()
    }
    
    private func getPhotoTypes() {
        Task {
            do {
                let photos = try await ApiManager.shared.getPhotoType(numberOfPage: currentPage)
                self.photoTypes = photos.content
                self.contentView.photoCollectionView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
