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

class ImageViewGradientForMain: UIImageView
{
  let myGradientLayer1: CAGradientLayer

  override init(frame: CGRect)
  {
    myGradientLayer1 = CAGradientLayer()
    super.init(frame: frame)
    self.setup()
  }

  required init?(coder aDecoder: NSCoder)
  {
    myGradientLayer1 = CAGradientLayer()
    super.init(coder: aDecoder)
    self.setup()
  }

  func setup()
  {
    myGradientLayer1.startPoint = CGPoint(x: 0.5, y: 0.47)
    myGradientLayer1.endPoint = CGPoint(x: 0.5, y: 0.9)
    let colors: [CGColor] = [
        UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
        UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor ]
    myGradientLayer1.colors = colors
    myGradientLayer1.isOpaque = false
    myGradientLayer1.locations = [0.35, 1]
   // myGradientLayer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
    //myGradientLayer1.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
    self.layer.addSublayer(myGradientLayer1)
  }

  override func layoutSubviews()
  {
    myGradientLayer1.frame = self.layer.bounds
  }
}
