//
//  GradientView.swift
//  Gojek-Assignment
//
//  Created by Amit on 29/08/19.
//  Copyright © 2019 Amit. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
final class GradientView: UIView {
//    @IBInspectable var startColor: UIColor = UIColor.clear
//    @IBInspectable var endColor: UIColor = UIColor.clear
    
//    override func draw(_ rect: CGRect) {
//        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.frame = CGRect(x: CGFloat(0),
//                                y: CGFloat(0),
//                                width: superview!.frame.size.width,
//                                height: superview!.frame.size.height)
//        gradient.colors = [startColor.cgColor, endColor.cgColor]
//        gradient.zPosition = -1
//        layer.addSublayer(gradient)
//    }
    
    
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor,secondColor.cgColor,
                                secondColor.cgColor]
       // gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.zPosition = -1
        layer.addSublayer(gradientLayer)
        return gradientLayer
    }()
    
    @IBInspectable var firstColor: UIColor = UIColor.clear
    @IBInspectable var secondColor: UIColor = UIColor.clear
    
    @IBInspectable var startX: CGFloat = 0.0 {
        didSet { gradientLayer.startPoint.x = startX }
    }
    @IBInspectable var startY: CGFloat = 0.5 {
        didSet { gradientLayer.startPoint.y = startY }
    }
    @IBInspectable var endX: CGFloat = 1.0 {
        didSet { gradientLayer.endPoint.x = endX }
    }
    @IBInspectable var endY: CGFloat = 0.5 {
        didSet { gradientLayer.endPoint.y = endY }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
}
