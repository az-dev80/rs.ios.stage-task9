//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Albert Zhloba
// On: 29.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    fileprivate let img: UIImageView = {
        let iv1 = UIImageView()
        iv1.translatesAutoresizingMaskIntoConstraints = false
        iv1.contentMode = .scaleAspectFill
        iv1.backgroundColor = .lightGray
        iv1.clipsToBounds = true
        iv1.layer.cornerRadius = 10
        iv1.layer.borderWidth = 1
        iv1.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        var a3view = ImageViewGradientForMain(frame: CGRect(x: 0, y: 0, width: 170, height: 220))
        iv1.addSubview(a3view)
        iv1.bringSubviewToFront(a3view)
        
        return iv1
    }()
    
    fileprivate let title:UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textAlignment = .left
        tl.textColor = .white
        tl.font = UIFont(name: "Rockwell-Regular", size: 16)
        
        return tl
    }()
    
    fileprivate let category:UILabel = {
        let cat = UILabel()
        cat.translatesAutoresizingMaskIntoConstraints = false
        cat.textAlignment = .left
        cat.textColor = UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1)
        cat.font = UIFont(name: "Rockwell-Regular", size: 12)
        
        return cat
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(img)
        contentView.addSubview(title)
        contentView.addSubview(category)
        
        contentView.layer.cornerRadius = 18
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        img.heightAnchor.constraint(equalToConstant: 200).isActive = true
        img.widthAnchor.constraint(equalToConstant: 163).isActive = true
        img.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
       
        title.leadingAnchor.constraint(equalTo: img.leadingAnchor, constant: 10).isActive = true
        title.heightAnchor.constraint(equalToConstant: 19).isActive = true
        title.widthAnchor.constraint(equalToConstant: 138).isActive = true
        title.bottomAnchor.constraint(equalTo: img.bottomAnchor, constant: -30).isActive = true
        
        category.leadingAnchor.constraint(equalTo: img.leadingAnchor, constant: 10).isActive = true
        category.heightAnchor.constraint(equalToConstant: 14).isActive = true
        category.widthAnchor.constraint(equalToConstant: 138).isActive = true
        category.bottomAnchor.constraint(equalTo: img.bottomAnchor, constant: -13).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var data: MyData? {
        
        didSet{
            guard let data = data else { return }
            img.image = data.image
            title.text = data.title
            category.text = data.category
            
        }
    }
}





