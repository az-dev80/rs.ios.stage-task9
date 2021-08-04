//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Albert Zhloba
// On: 30.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ModalCollectionViewCellGallery: UICollectionViewCell {
    
    fileprivate var img1: UIImageView = {
        let image2 = UIImageView()
        image2.layer.cornerRadius = 4
        image2.translatesAutoresizingMaskIntoConstraints = false
        image2.contentMode = .scaleAspectFill
        image2.clipsToBounds = true
        
        return image2
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //img1.frame = contentView.bounds
        self.addSubview(img1)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        img1.heightAnchor.constraint(equalToConstant: 491).isActive = true
        img1.widthAnchor.constraint(equalToConstant: 354).isActive = true
        img1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        img1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        //img1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        //img1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        //img1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var data: UIImage? {
        didSet{
            guard let data = data else { return }
            img1.image = data 
        }
    }
}
