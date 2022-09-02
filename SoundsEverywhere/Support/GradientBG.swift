//
//  GradientBG.swift
//  rss.ios.stage3-final task
//
//  Created by Albert Zhloba on 10.11.21.
//

import Foundation
import UIKit
import AVFoundation

class GradientBG: UIImageView
{
  let myGradientLayer: CAGradientLayer

    init(frame: CGRect, rad:CGFloat = 5)
  {
    myGradientLayer = CAGradientLayer()
        super.init(frame: frame)
        self.setup(rad:rad)
  }

  required init?(coder aDecoder: NSCoder)
  {
    myGradientLayer = CAGradientLayer()
    super.init(coder: aDecoder)
    self.setup(rad: 5)
  }

  func setup(rad:CGFloat)
  {
    myGradientLayer.startPoint = CGPoint(x: 0.75, y: 0.5)
    myGradientLayer.endPoint = CGPoint(x: 0.25, y: 0.5)
    let colors: [CGColor] = [
        UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.55).cgColor,
        UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.85).cgColor ]
    myGradientLayer.colors = colors
    myGradientLayer.isOpaque = false
    myGradientLayer.locations = [0, 1]
    //myGradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -1, b: -1, c: 1.09, d: -2.91, tx: 0.46, ty: 2.45))
    myGradientLayer.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
    myGradientLayer.cornerRadius = rad
    myGradientLayer.cornerCurve = .continuous
    myGradientLayer.position = self.center
    self.layer.addSublayer(myGradientLayer)
  }

  override func layoutSubviews()
  {
    myGradientLayer.frame = self.layer.bounds
  }
}
