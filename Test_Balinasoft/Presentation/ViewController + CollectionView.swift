//
//  ViewController + CollectionView.swift
//  Test_Balinasoft
//
//  Created by Hleb Karpovich on 30.12.23.
//

import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
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
                    self.photoCollectionView.reloadData()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    
}
