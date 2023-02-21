//
//  UIView+Animation.swift
//  Restaurant
//
//  Created by Amr Elghadban (AmrAngry) on 5/16/19.
//  Copyright © 2019 adka. All rights reserved.
//

import UIKit

public extension UIView {
    func shakeAnimation(completion: (() -> Void)?) {
        let keyFrame = CAKeyframeAnimation(keyPath: "position")
        let point = self.layer.position
        keyFrame.values = [NSValue(cgPoint: CGPoint(x: CGFloat(point.x), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x - 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x + 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x - 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x + 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x - 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x + 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: point)]
        
        keyFrame.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        keyFrame.duration = 0.7
        self.layer.position = point
        
        CATransaction.setCompletionBlock {
            completion?()
        }
        self.layer.add(keyFrame, forKey: keyFrame.keyPath)
        
        CATransaction.commit()
    }
}
