//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Albert Zhloba
// On: 30.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ModalViewControllerStory: UIViewController {
    
    var pathArray:[CGPath]!
    var imgStoryCover:UIImage!
    var ttlStory: String!
    var catStory: String!
    var textStory: String!
    
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    lazy var scrollView: UIScrollView = {
           let scroll = UIScrollView()
           scroll.translatesAutoresizingMaskIntoConstraints = false
           scroll.delegate = self
           //scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
           return scroll
       }()
    
    fileprivate let buttonStory: UIButton = {
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
        //iv.backgroundColor = .lightGray
        bt.clipsToBounds = true
        bt.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return bt
    }()
    
    fileprivate let imgStory: UIImageView = {
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
    
    fileprivate let titleStory:UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textAlignment = .left
        tl.textColor = .white
        tl.font = UIFont(name: "Rockwell-Regular", size: 48)
        tl.numberOfLines = 0
        tl.lineBreakMode = .byWordWrapping
        
        return tl
    }()
    
    fileprivate let categoryStory:UILabel = {
        let cat = UILabel()
        cat.translatesAutoresizingMaskIntoConstraints = false
        cat.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        cat.textAlignment = .center
        cat.textColor = .white
        cat.font = UIFont(name: "Rockwell-Regular", size: 24)
        cat.layer.borderWidth = 1
        cat.layer.cornerRadius = 8
        cat.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        return cat
    }()
    
    fileprivate let delimiter:UIView = {
        let del = UIView()
        del.translatesAutoresizingMaskIntoConstraints = false
        del.frame = CGRect(x: 0, y: 0, width: 214, height: 1)
        del.backgroundColor = .white
        
        return del
    }()
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 50, height: 50)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ModalCollectionViewCellStory.self, forCellWithReuseIdentifier: "cell")
        
        return cv
    }()
    
    fileprivate let addTextView:UIView = {
        let addText = UIView()
        addText.translatesAutoresizingMaskIntoConstraints = false
        addText.layer.cornerRadius = 8
        addText.layer.borderWidth = 1
        addText.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        //addText.frame = CGRect(x: 0, y: 0, width: 214, height: 1)
       
        return addText
    }()
    
    fileprivate let textStories:UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textAlignment = .left
        tl.textColor = .white
        tl.font = UIFont(name: "Rockwell-Regular", size: 24)
        tl.numberOfLines = 0
        tl.lineBreakMode = .byWordWrapping
        
        return tl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.alwaysBounceHorizontal = true
        imgStory.image = imgStoryCover
        titleStory.text = ttlStory
        categoryStory.text = catStory
        textStories.text = textStory
        
        setupView()
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1595)
        
    }
     
    @objc func buttonAction() {
        dismiss(animated: true, completion: nil)
    }
    
//    override func viewDidLayoutSubviews() {
//           super.viewDidLayoutSubviews()
//           let layout = view.safeAreaLayoutGuide
//           scrollView.centerXAnchor.constraint(equalTo: layout.centerXAnchor).isActive = true
//           scrollView.centerYAnchor.constraint(equalTo: layout.centerYAnchor).isActive = true
//           scrollView.widthAnchor.constraint(equalTo: layout.widthAnchor).isActive = true
//           scrollView.heightAnchor.constraint(equalTo: layout.heightAnchor).isActive = true
//       }

    func setupView(){
        view.backgroundColor = .black
        view.addSubview(scrollView)
        scrollView.addSubview(buttonStory)
        scrollView.addSubview(imgStory)
        scrollView.addSubview(titleStory)
        scrollView.addSubview(categoryStory)
        scrollView.addSubview(delimiter)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(addTextView)
        scrollView.addSubview(textStories)
        setupconstraint()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
    }
    
    func setupconstraint(){
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        buttonStory.widthAnchor.constraint(equalToConstant: 40).isActive = true
        buttonStory.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonStory.trailingAnchor.constraint(equalTo: imgStory.trailingAnchor, constant: -5).isActive = true
        buttonStory.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30).isActive = true
        
        imgStory.topAnchor.constraint(equalTo: buttonStory.bottomAnchor, constant: 30).isActive = true
        imgStory.heightAnchor.constraint(equalToConstant: 500).isActive = true
        imgStory.widthAnchor.constraint(equalToConstant: 374).isActive = true
        
        imgStory.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        titleStory.bottomAnchor.constraint(equalTo: imgStory.bottomAnchor, constant: -55).isActive = true
        titleStory.widthAnchor.constraint(equalToConstant: 314).isActive = true
        titleStory.heightAnchor.constraint(equalToConstant: 116).isActive = true
        titleStory.leadingAnchor.constraint(equalTo: imgStory.leadingAnchor, constant: 30).isActive = true

        categoryStory.leadingAnchor.constraint(equalTo: imgStory.leadingAnchor, constant: 126).isActive = true
        categoryStory.widthAnchor.constraint(equalToConstant: 122).isActive = true
        categoryStory.heightAnchor.constraint(equalToConstant: 40).isActive = true
        categoryStory.bottomAnchor.constraint(equalTo: imgStory.bottomAnchor, constant: 19).isActive = true
        
        delimiter.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        delimiter.widthAnchor.constraint(equalToConstant: 214).isActive = true
        delimiter.heightAnchor.constraint(equalToConstant: 1).isActive = true
        delimiter.bottomAnchor.constraint(equalTo: imgStory.bottomAnchor, constant: 58).isActive = true

        collectionView.topAnchor.constraint(equalTo: delimiter.bottomAnchor, constant: 40).isActive = true
        //collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: 374).isActive = true
        
        addTextView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40).isActive = true
        addTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        addTextView.widthAnchor.constraint(equalToConstant: 374).isActive = true
        addTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30).isActive = true
        //addTextView.heightAnchor.constraint(equalToConstant: 727).isActive = true
        
        textStories.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 70).isActive = true
        textStories.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        textStories.widthAnchor.constraint(equalToConstant: 304).isActive = true
        textStories.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -60).isActive = true
        //textStories.heightAnchor.constraint(equalToConstant: 667).isActive = true
       
    }
    override var prefersStatusBarHidden: Bool {
          return true
    }
}

extension ModalViewControllerStory: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pathArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ModalCollectionViewCellStory
        //cell.backgroundColor = .red
        cell.data = pathArray[indexPath.item]

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let padding = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = view.frame.width - padding
//        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: 165, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? ModalCollectionViewCellStory {
            cell.redraw()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? ModalCollectionViewCellStory {
            cell.clean()
        }
    }
    
}
