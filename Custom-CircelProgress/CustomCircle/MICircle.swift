//
//  MICircle.swift
//  Custom-CircelProgress
//
//  Created by M Akbari on 4/4/1398 AP.
//  Copyright © 1398 M Akbari. All rights reserved.
//

import UIKit


class MICircle: UIView {
    
   internal var shapeLayer:CAShapeLayer!
   internal var trackLayer:CAShapeLayer!
   internal var pulsingLayer:CAShapeLayer!
    
   internal var labelPresntage:UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func refactorShape(_ strokColor:UIColor,_ fillColor:UIColor)->CAShapeLayer {
        let shape = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shape.path = circularPath.cgPath
        shape.strokeColor = strokColor.cgColor
        shape.lineWidth = 20
        shape.lineCap = .round
        shape.fillColor = fillColor.cgColor
        shape.position = center
        shape.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        layer.addSublayer(shape)
        return shape
    }

    fileprivate func setupTextPresntage() {
        addSubview(labelPresntage)
        labelPresntage.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        labelPresntage.center = center
    }
    
    private func setupView() {
        backgroundColor = .black
        
        pulsingLayer = refactorShape(.clear,#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1))
        trackLayer = refactorShape(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), .black)
        shapeLayer = refactorShape(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), .clear)
        shapeLayer.strokeEnd = 0

        setupTextPresntage()
        
    }
    
    internal func animatePulsingLayer(_ isAc:Bool) {
        if isAc == true {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.toValue = 1.5
            animation.duration = 0.8
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            animation.autoreverses = true
            animation.repeatCount = Float.infinity
            pulsingLayer.add(animation, forKey: "pulsing")
        }
        
    }
}

