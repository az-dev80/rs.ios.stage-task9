//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Albert Zhloba
// On: 31.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import Foundation
import UIKit
import AVFoundation


class ImageViewWithGradient: UIImageView
{
  let myGradientLayer: CAGradientLayer

  override init(frame: CGRect)
  {
    myGradientLayer = CAGradientLayer()
    super.init(frame: frame)
    self.setup()
  }

  required init?(coder aDecoder: NSCoder)
  {
    myGradientLayer = CAGradientLayer()
    super.init(coder: aDecoder)
    self.setup()
  }

  func setup()
  {
    myGradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
    myGradientLayer.endPoint = CGPoint(x: 0.99, y: 0.5)
    let colors: [CGColor] = [
        UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
        UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor ]
    myGradientLayer.colors = colors
    myGradientLayer.isOpaque = false
    myGradientLayer.locations = [0.51, 1.0]
    myGradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
    myGradientLayer.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
    self.layer.addSublayer(myGradientLayer)
  }

  override func layoutSubviews()
  {
    myGradientLayer.frame = self.layer.bounds
  }
}


var aView = ImageViewWithGradient(frame: CGRect(x: 0, y: 0, width: 374, height: 500))

