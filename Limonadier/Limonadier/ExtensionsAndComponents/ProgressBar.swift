//
//  ProgressBar.swift
//  limonadier
//
//  Created by Céline on 25/02/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import UIKit

class ProgressBar: UIView {
    
    /*var barPath: UIBezierPath!
    var backgroundLayer: CAShapeLayer!
    var progressLayer: CAShapeLayer!
    
    var progress: Float = 0.33 {
        willSet(newValue)
        {
            progressLayer.strokeEnd = CGFloat(newValue)
        }
    }
    
    var progressColor = UIColor.titleColor
    var pathColor = UIColor.defaultTextColor
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor.clear
        barPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: (rect.width / 2.0), height: (rect.height / 2.0)))
        barPath.close()
        
        backgroundLayer = CAShapeLayer()
        backgroundLayer.path = barPath.cgPath
        backgroundLayer.fillColor = self.pathColor?.cgColor
        
        
        progressLayer = CAShapeLayer()
        progressLayer.path = barPath.cgPath
        progressLayer.fillColor = progressColor?.cgColor
        //progressLayer.strokeEnd = 0.33
        
        self.layer.addSublayer(backgroundLayer)
        self.layer.addSublayer(progressLayer)
        
    }*/
    
    var shapePath: UIBezierPath!
    var shapeLayer: CAShapeLayer?
    var progressPath: UIBezierPath!
    var progressLayer: CAShapeLayer?
    
    var progress: CGFloat = 0.5 {
        didSet {
            self.simpleShape()
        }
    }
    @IBInspectable var progressColor: UIColor = UIColor.black
    @IBInspectable var shapeColor: UIColor = UIColor.lightGray
    
    
    private func rectPath(isProgress: Bool = false) -> UIBezierPath {
        var rect = frame
        if isProgress {
            rect.size.width = frame.width * min(progress, 1)
        }
        let path = UIBezierPath.init(roundedRect: rect, cornerRadius: 5)
        return path
    }
    
    func simpleShape() {
        //shapeLayer?.removeFromSuperlayer()
        shapeLayer = CAShapeLayer()
        shapePath = rectPath()
        shapeLayer?.path = shapePath.cgPath
        shapeLayer?.fillColor = shapeColor.cgColor
        self.layer.addSublayer(shapeLayer!)
        
        //progressLayer?.removeFromSuperlayer()
        progressLayer = CAShapeLayer()
        progressPath = rectPath(isProgress: true)
        progressLayer?.path = progressPath.cgPath
        progressLayer?.fillColor = progressColor.cgColor
        self.layer.addSublayer(progressLayer!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.simpleShape()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.simpleShape()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.simpleShape()
    }
    
}
