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
        return view
    }()
    
    private lazy var photoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "noImage")
        image.clipsToBounds = true
        image.layer.cornerRadius = 40
        return image
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutPhotoCollectionViewCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPhotoType(info: Content) {
        nameLabel.text = info.name
        idLabel.text = String("\(info.id)")
        let currentImageURL = info.image ?? ""
        setPhoto(urlString: currentImageURL)
    }
    
    private func setPhoto(urlString: String) {
        let placeholderImage = UIImage(named: "noImage")
        let imageURL = URL(string: urlString)
        photoImageView.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
    }
    
    private func layoutPhotoCollectionViewCell() {
        contentView.addSubview(mainView)
        mainView.addSubview(photoImageView)
        mainView.addSubview(nameLabel)
        mainView.addSubview(idLabel)
        mainView.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview()
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
}
