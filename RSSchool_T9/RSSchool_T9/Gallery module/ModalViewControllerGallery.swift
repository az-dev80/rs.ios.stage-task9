//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Albert Zhloba
// On: 30.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ModalViewControllerGallery: UIViewController {

    var imgArray:[UIImage]!
    var imgGalleryCover:UIImage!
    var galleryStory: String!
    var catGallery: String!
    var wideConstraints: [NSLayoutConstraint] = []
    var narrowConstraints: [NSLayoutConstraint] = []
    var commonConstraints: [NSLayoutConstraint] = []
    private let itemsPerRow: CGFloat = 1
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    fileprivate let collectionView2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        //layout.itemSize = .init(width: 354, height: 491)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ModalCollectionViewCellGallery.self, forCellWithReuseIdentifier: "cell1")
        cv.register(HeaderForCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "cell2")
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        view.backgroundColor = .black
        view.addSubview(collectionView2)
        
        setupconstraint()
        collectionView2.delegate = self
        collectionView2.dataSource = self
    }
    
    func setupconstraint(){
        commonConstraints = [
            collectionView2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView2.heightAnchor.constraint(equalTo: view.heightAnchor)
        ]
        
        narrowConstraints = [
            collectionView2.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        
        wideConstraints = [
            collectionView2.widthAnchor.constraint(equalToConstant: 540)
        ]
        
        NSLayoutConstraint.activate(commonConstraints)
        if view.frame.width > view.frame.height {
            NSLayoutConstraint.activate(wideConstraints)
        } else {
            NSLayoutConstraint.activate(narrowConstraints)
        }
        
//        collectionView2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        collectionView2.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        collectionView2.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        collectionView2.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
     }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            if size.width > size.height {
                NSLayoutConstraint.deactivate(self.narrowConstraints)
                NSLayoutConstraint.activate(self.wideConstraints)
            } else {
                NSLayoutConstraint.deactivate(self.wideConstraints)
                NSLayoutConstraint.activate(self.narrowConstraints)
            }
        }, completion: {
            _ in
            
        })
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension ModalViewControllerGallery: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! ModalCollectionViewCellGallery
        //cell.backgroundColor = .red
        cell.data = imgArray[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let padding = sectionInsets.left * (itemsPerRow + 1)
//        let availableWidth = view.frame.width - padding
//        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: 374, height: 511)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView2.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "cell2", for: indexPath) as! HeaderForCollectionView
        header.galleryStoryData = galleryStory
        header.catGalleryData = catGallery
        header.imgGalleryCoverData = imgGalleryCover
        header.buttonStory1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 699)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageInfo = DetailImageInfo(image: imgArray[indexPath.row], imageMode: .aspectFit)
        let transitionInfo = DetailTransitionInfo(fromView: collectionView2)
        let imageInDetail = DetailViewController(imageInfo: imageInfo, transitionInfo: transitionInfo)
        imageInDetail.dismissCompletion = {
            print("dismissed called")
        }
        present(imageInDetail, animated: true, completion: nil)
    }
    
    @objc func buttonAction() {
        dismiss(animated: true, completion: nil)
    }
}
