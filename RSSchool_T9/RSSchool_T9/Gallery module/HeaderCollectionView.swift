//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Albert Zhloba
// On: 2.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import Foundation
import UIKit

class HeaderForCollectionView: UICollectionReusableView  {
    
    override init(frame: CGRect)    {
        super.init(frame: frame)
        setupHeader()
    }
    
        let buttonStory1: UIButton = {
        let bt = UIButton()
        bt.setTitle("+", for: .normal)
        bt.setTitleColor(UIColor(red: 0.475, green: 0.475, blue: 0.475, alpha: 1), for: .highlighted)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 42, weight: .thin)
        bt.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
        bt.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 6, right: 0)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.layer.borderWidth = 1
        bt.layer.cornerRadius = 20
        bt.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        bt.clipsToBounds = true
        
        return bt
    }()
    
    fileprivate let imgStory1: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 1
        iv.layer.cornerRadius = 8
        iv.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        iv.clipsToBounds = true
        iv.addSubview(aView)
        iv.bringSubviewToFront(aView)
        
        return iv
    }()
    
    fileprivate let titleStory1:UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textAlignment = .left
        tl.textColor = .white
        tl.font = UIFont(name: "Rockwell-Regular", size: 48)
        tl.numberOfLines = 0
        tl.lineBreakMode = .byWordWrapping
        
        return tl
    }()
    
    fileprivate let categoryStory1:UILabel = {
        let cat = UILabel()
        cat.translatesAutoresizingMaskIntoConstraints = false
        cat.textAlignment = .center
        cat.textColor = .white
        cat.font = UIFont(name: "Rockwell-Regular", size: 24)
        cat.layer.borderWidth = 1
        cat.layer.cornerRadius = 8
        cat.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        cat.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        return cat
    }()
    
    fileprivate let delimiter1:UIView = {
        let del = UIView()
        del.translatesAutoresizingMaskIntoConstraints = false
        del.frame = CGRect(x: 0, y: 0, width: 214, height: 1)
        del.backgroundColor = .white
        
        return del
    }()
    
    func setupHeader()   {
        
        self.addSubview(buttonStory1)
        self.addSubview(imgStory1)
        self.addSubview(titleStory1)
        self.addSubview(categoryStory1)
        self.addSubview(delimiter1)
        
        buttonStory1.widthAnchor.constraint(equalToConstant: 40).isActive = true
        buttonStory1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonStory1.trailingAnchor.constraint(equalTo: imgStory1.trailingAnchor, constant: -5).isActive = true
        buttonStory1.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        
        imgStory1.topAnchor.constraint(equalTo: buttonStory1.bottomAnchor, constant: 30).isActive = true
        imgStory1.heightAnchor.constraint(equalToConstant: 500).isActive = true
        imgStory1.widthAnchor.constraint(equalToConstant: 374).isActive = true
        
        imgStory1.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        titleStory1.bottomAnchor.constraint(equalTo: imgStory1.bottomAnchor, constant: -55).isActive = true
        titleStory1.widthAnchor.constraint(equalToConstant: 314).isActive = true
        titleStory1.heightAnchor.constraint(equalToConstant: 116).isActive = true
        titleStory1.leadingAnchor.constraint(equalTo: imgStory1.leadingAnchor, constant: 30).isActive = true
        
        categoryStory1.centerXAnchor.constraint(equalTo: imgStory1.centerXAnchor).isActive = true
        categoryStory1.widthAnchor.constraint(equalToConstant: 122).isActive = true
        categoryStory1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        categoryStory1.bottomAnchor.constraint(equalTo: imgStory1.bottomAnchor, constant: 19).isActive = true
        
        delimiter1.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        delimiter1.widthAnchor.constraint(equalToConstant: 214).isActive = true
        delimiter1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        delimiter1.topAnchor.constraint(equalTo: imgStory1.bottomAnchor, constant: 58).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imgGalleryCoverData: UIImage? {
        didSet{
            guard let imgGalleryCoverData = imgGalleryCoverData else { return }
            imgStory1.image = imgGalleryCoverData
        }
    }
    var galleryStoryData: String? {
        didSet{
            guard let galleryStoryData = galleryStoryData else { return }
            titleStory1.text = galleryStoryData
        }
    }
    var catGalleryData: String? {
        didSet{
            guard let catGalleryData = catGalleryData else { return }
            categoryStory1.text = catGalleryData
        }
    }
}
