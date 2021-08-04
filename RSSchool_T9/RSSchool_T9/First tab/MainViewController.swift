//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Albert Zhloba
// On: 28.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

extension String {
    static func from1(_ file: String) -> String {
        guard let path = Bundle.main.path(forResource: file, ofType: "txt") else {
            fatalError("LOL, be careful, drink some water")
        }
        return try! String(contentsOfFile: path)
    }
}

struct MyData{
    var title: String
    var image: UIImage
    var category: String
    let text: String
    let paths: [CGPath]
    let images: [UIImage]
}

class MainViewController: UIViewController {
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var wideConstraints: [NSLayoutConstraint] = []
    var narrowConstraints: [NSLayoutConstraint] = []
    var commonConstraints: [NSLayoutConstraint] = []
    
    fileprivate let data = [
        MyData(title: String.from("s1-title"), image: UIImage(named: "story-1")!, category: "Story", text: String.from("s1-text"), paths: [.story1path1, .story1path2, .story1path3], images: []),
        MyData(title: String.from("s2-title"), image: UIImage(named:"story-2")!, category: "Story", text: String.from("s2-text"), paths: [.story2path1, .story2path2], images: []),
        MyData(title: "Minsk", image: UIImage(named:"minsk-0")!, category: "Gallery", text: "", paths: [], images: .init(base: "minsk", count: 6)),
        MyData(title: "Apple", image: UIImage(named:"apple-0")!, category: "Gallery", text: "", paths: [], images: .init(base: "apple", count: 7)),
        
        MyData(title: String.from("s4-title"), image: UIImage(named:"story-4")!, category: "Story", text: String.from("s4-text"), paths: [.story4path1, .story4path2], images: []),
        MyData(title: "Code stuff", image: UIImage(named:"code-0")!, category: "Gallery", text: "", paths: [], images: .init(base: "code", count: 10)),
        MyData(title: "Tesla", image: UIImage(named:"tesla-0")!, category: "Gallery", text: "", paths: [], images: .init(base: "tesla", count: 8)),
        MyData(title: String.from("s3-title"), image: UIImage(named:"story-3")!, category: "Story", text: String.from("s3-text"), paths: [.story3path1, .story3path1, .story3path1, .story3path1], images: [])
    ]
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 30
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .white
        
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        view.addSubview(collectionView)
        setupconstraint()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupconstraint(){
        //let g = view.safeAreaLayoutGuide
        commonConstraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant:  40),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        narrowConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
        ]
        
        wideConstraints = [
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: 374)
        ]
        
        NSLayoutConstraint.activate(commonConstraints)
        if view.frame.width > view.frame.height {
            NSLayoutConstraint.activate(wideConstraints)
        } else {
            NSLayoutConstraint.activate(narrowConstraints)
        }
//        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant:  40).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.data = data[indexPath.row] 
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let padding = sectionInsets.left * (itemsPerRow + 1)
        //let availableWidth = view.frame.width - padding
        //let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: 179, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indItem = data[indexPath.item]
        if (indItem.category == "Story"){
            let modalVCStory = ModalViewControllerStory()
            modalVCStory.modalPresentationStyle = .fullScreen
            modalVCStory.pathArray = indItem.paths
            modalVCStory.imgStoryCover = indItem.image
            modalVCStory.ttlStory = indItem.title
            modalVCStory.catStory = indItem.category
            modalVCStory.textStory = indItem.text
            self.present(modalVCStory, animated: true, completion: nil)
        }
        else {
            let modalVCGallery = ModalViewControllerGallery()
            modalVCGallery.modalPresentationStyle = .fullScreen
            modalVCGallery.imgArray = indItem.images
            modalVCGallery.imgGalleryCover = indItem.image
            modalVCGallery.galleryStory = indItem.title
            modalVCGallery.catGallery = indItem.category
            self.present(modalVCGallery, animated: true, completion: nil)
        }
    }
}




