//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Albert Zhloba
// On: 30.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.
import UIKit

@objc class ModalCollectionViewCellStory: UICollectionViewCell {
   
    @objc public var timer1 = Timer()
    @objc public var valueToPass: CGFloat = 0.0
    
    fileprivate var img: CAShapeLayer = {
        let image1 = CAShapeLayer()
        //image1.strokeColor = UIColor(named: "#f3af22")?.cgColor
        image1.lineWidth = 1.0
        image1.name = "ShapeLayer"
        return image1
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bounds = CGRect(x: -51, y: 0, width: 73, height: 61)
        img.frame = contentView.bounds
        self.layer.addSublayer(img)
        
        let colorInstance: ColorViewController = ColorViewController()
        colorInstance.colorForDrawing()
        img.strokeColor = UIColor(named: colorInstance.colorName)?.cgColor
        
        let instance: SecondaryViewController = SecondaryViewController()
        instance.valueForPass()
        img.strokeEnd = instance.timerValueObj
        
        timer1 = Timer.scheduledTimer(timeInterval: 0.015, target: self, selector: #selector(timerListener), userInfo: nil, repeats: true)
        //RunLoop.main.add(timer1, forMode: RunLoop.Mode.common)
        
    }
    
    @objc func timerListener(){
        img.strokeEnd += 0.005;
        if (img.strokeEnd > 1){
            timer1.invalidate()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var data: CGPath? {
        didSet{
            guard let data = data else { return }
            img.path = data
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.frame = contentView.bounds
        
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        contentView.removeFromSuperview()
//        //self.setNeedsDisplay()
//        
//    }
}
