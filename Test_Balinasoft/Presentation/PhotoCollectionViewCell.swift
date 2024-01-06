//
//  PhotoCollectionViewCell.swift
//  Test_Balinasoft
//
//  Created by Hleb Karpovich on 30.12.23.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {

    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var photoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 40
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "noImage")
        return image
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        layoutPhotoCollectionViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutPhotoCollectionViewCell() {
        contentView.addSubview(mainView)
        mainView.addSubview(photoImageView)
        mainView.addSubview(nameLabel)
        mainView.addSubview(idLabel)
        mainView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(idLabel.snp.top).inset(-5)
            make.height.equalTo(200)
        }
        idLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.top).inset(-5)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
        }
    }
    
    func setPhoto(url: String) {
        if let url = URL(string: url) {
            photoImageView.sd_setImage(with: url)
        } else {
            photoImageView.image = UIImage(named: "noImage")
        }
    }
    
    func setPhotoType(info: Content) {
        nameLabel.text = info.name
        idLabel.text = String("\(info.id)")
        let currentImageURL = info.image ?? ""
        setPhoto(url: currentImageURL)
    }
}
