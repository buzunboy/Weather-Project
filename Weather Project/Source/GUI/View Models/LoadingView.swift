//
//  LoadingView.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 16.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

@IBDesignable
class LoadingView: UIView {
    
    private var minRadiiOffset = 10

    private var blurBackgroundViewStyle: UIBlurEffect.Style = .dark
    private var maxRadii: CGFloat!
    private var latestRadii: Int! = 1
    private var isGrown: Bool = false
    private var shouldAnimate = true
    private var latestColorNum = 0
    private var timer: Timer!
    
    private var animationView: UIView!
    private var backgroundBlurView: UIVisualEffectView!
    
    /**
     * Initializes LR Loading Indicator on a base point with given radius.
     * - parameter maxRadii: Radius for the indicator.
     */
    init(maxRadii: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: maxRadii, height: maxRadii))
        self.initialize(maxRadii: maxRadii)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize(maxRadii: (self.frame.width > self.frame.height) ? self.frame.height : self.frame.width)
    }
    
    private func initialize(maxRadii: CGFloat) {
        self.maxRadii = maxRadii
        self.animationView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.animationView.layer.cornerRadius = 1
        self.animationView.backgroundColor = .clear
        self.clipsToBounds = true
        self.animationView.clipsToBounds = true
        
        self.backgroundColor = .clear
        self.latestRadii = 1
        self.animationView.layer.borderWidth = 4
        
        self.backgroundBlurView = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        self.backgroundBlurView.effect = UIBlurEffect(style: self.blurBackgroundViewStyle)
        self.backgroundBlurView.layer.cornerRadius = self.frame.width/4
        self.backgroundBlurView.isHidden = false
        self.backgroundBlurView.clipsToBounds = true
        
        self.addSubview(self.backgroundBlurView)
        self.addSubview(self.animationView)
        
        self.startBeginning()
    }
    
    private func startBeginning() {
        self.isGrown = false
        self.animationView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.animationView.layer.cornerRadius = 1
        self.latestRadii = 1
        self.animationView.center = self.convert(self.center, from: self.superview)
        self.bringSubviewToFront(self.animationView)
        self.isHidden = true
    }
    
    /**
     * Starts to animate the indicator.
     */
    public func startAnimating() {
        self.startBeginning()
        self.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            let radii = self.randomizeRadii()
            self.animationView.frame = CGRect(x: 0, y: 0, width: radii, height: radii)
            self.animationView.center = self.convert(self.center, from: self.superview)
            self.animationView.layer.cornerRadius = CGFloat(radii/2)
            self.animationView.layer.borderColor = self.randomizeColor().cgColor
        }, completion: nil)
    }
    
    /**
     * Stops animation and hides the indicator.
     */
    public func stopAnimating() {
        self.isHidden = true
        timer.invalidate()
    }
    
    @objc private func animate() {
        var radii = self.randomizeRadii()
        if radii <= minRadiiOffset { radii = radii + minRadiiOffset }
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            self.animationView.frame = CGRect(x: 0, y: 0, width: radii, height: radii)
            self.animationView.center = self.convert(self.center, from: self.superview)
            self.animationView.layer.cornerRadius = CGFloat(radii/2)
            self.animationView.layer.borderColor = self.randomizeColor().cgColor
        }, completion: nil)
    }
    
    private func randomizeRadii() -> Int {
        var retVal = Int(arc4random_uniform(UInt32(maxRadii/5)))*5
        if isGrown {
            while retVal > self.latestRadii {
                retVal = Int(arc4random_uniform(UInt32(maxRadii)))
            }
            isGrown = false
        } else {
            while retVal < self.latestRadii {
                retVal = Int(arc4random_uniform(UInt32(maxRadii)))
            }
            isGrown = true
        }
        self.latestRadii = retVal
        return retVal
    }
    
    private func randomizeColor() -> UIColor {
        var retVal = Int(arc4random_uniform(6))
        while retVal == self.latestColorNum {
            retVal = Int(arc4random_uniform(6))
        }
        return self.colors[retVal]
    }
    
    private var colors = [
        UIColor.blue,
        UIColor.cyan,
        UIColor.green,
        UIColor.magenta,
        UIColor.orange,
        UIColor.red,
        UIColor.yellow
    ]
    
}
