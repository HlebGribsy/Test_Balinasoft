//
//  ViewController + CollectionView.swift
//  Test_Balinasoft
//
//  Created by Hleb Karpovich on 30.12.23.
//

import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        contentView.photoCollectionView.delegate = self
        contentView.photoCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell
        cell?.setPhotoType(info: photoTypes[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if currentPage < totalPage && indexPath.row == photoTypes.count - 1 {
            Task {
                do {
                    currentPage = currentPage + 1
                    let photos = try await ApiManager.shared.getPhotoType(numberOfPage: currentPage)
                    self.photoTypes.append(contentsOf: photos.content)
                    self.contentView.photoCollectionView.reloadData()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.typeId = photoTypes[indexPath.row].id
        let camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = .camera
        self.present(camera, animated: true, completion: nil)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            ApiManager.shared.postPhotoType(name: "Karpovich Hleb Olegovich", photo: image.jpegData(compressionQuality: 1)!, typeId: "\(self.typeId ?? 0)")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
