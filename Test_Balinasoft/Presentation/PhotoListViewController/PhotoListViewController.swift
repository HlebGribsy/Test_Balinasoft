//
//  PhotoListViewController.swift
//  Test_Balinasoft
//
//  Created by Hleb Karpovich on 30.12.23.
//

import UIKit
import SnapKit

final class PhotoListViewController: UIViewController {
    
    private(set) var contentView = PhotoListViewControllerView()
    
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
        
        getFirstPagePhotoTypes()
        setupCollectionView()
    }
    
    func openCamera() {
        let camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = .camera
        self.present(camera, animated: true, completion: nil)
    }
    
    private func errorAlert() {
        let alert = UIAlertController(title: "Ой🤕", message: "Что-то пошло не так. Попробуйте ещё раз!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func getFirstPagePhotoTypes() {
        Task {
            do {
                let photos = try await ApiManager.shared.getPhotoType(numberOfPage: currentPage)
                self.photoTypes = photos.content
                self.contentView.photoCollectionView.reloadData()
            } catch {
                errorAlert()
            }
        }
    }
    
    func loadMorePhotoTypes() {
        Task {
            do {
                currentPage = currentPage + 1
                let photos = try await ApiManager.shared.getPhotoType(numberOfPage: currentPage)
                self.photoTypes.append(contentsOf: photos.content)
                self.contentView.photoCollectionView.reloadData()
            } catch {
                errorAlert()
            }
        }
    }
    
}
