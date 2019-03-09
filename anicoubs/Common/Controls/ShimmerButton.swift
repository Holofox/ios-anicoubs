//
//  ShimmerButton.swift
//  anicoubs
//
//  Created by Holofox on 06.02.2019.
//  Copyright © 2019 Holofox. All rights reserved.
//

import UIKit

// MARK: UIButton with animated 'shimmer' effect
// https://codereview.stackexchange.com/a/158338
// By @MathewS

protocol ShimmerEffect {
    var animationDuration: TimeInterval { set get }
    var animationDelay: TimeInterval {set get }
    
    var gradientTint: UIColor { set get }
    var gradientHighlight: UIColor { set get }
    
    /* Expects value between 0.0—1.0 that represents
     the ratio of the gradient highlight to the full
     width of the gradient. */
    var gradientHighlightRatio: Double { set get }
    
    // The layer that the gradient will be applied to
    var gradientLayer: CAGradientLayer { get }
}

class ShimmerButton: UIButton, ShimmerEffect {
    
    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    var animationDuration: TimeInterval = 3 {
        didSet { addShimmerAnimation() }
    }
    var animationDelay: TimeInterval = 1.5 {
        didSet { addShimmerAnimation() }
    }
    
    var gradientHighlightRatio: Double = 0.3 {
        didSet { addShimmerAnimation() }
    }
    
    var gradientTint: UIColor = .black {
        didSet { addShimmerAnimation() }
    }
    
    var gradientHighlight: UIColor = .white {
        didSet { addShimmerAnimation() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientLayer.mask = titleLabel?.layer
        addShimmerAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        gradientLayer.mask = titleLabel?.layer
        addShimmerAnimation()
    }
}

extension ShimmerEffect {
    
    // Configures, and adds the animation to the gradientLayer
    func addShimmerAnimation() {
        
        // `gradientHighlightRatio` represents how wide the highlight
        // should be compared to the entire width of the gradient and
        // is used to calculate the positions of the 3 gradient colors.
        // If the highlight is 20% width of the gradient, then the
        // 'start locations' would be [-0.2, -0.1, 0.0] and the
        // 'end locations' would be [1.0, 1.1, 1.2]
        let startLocations = [NSNumber(value: -gradientHighlightRatio), NSNumber(value: -gradientHighlightRatio/2), 0.0]
        let endLocations = [1, NSNumber(value: 1+(gradientHighlightRatio/2)), NSNumber(value: 1+gradientHighlightRatio)]
        let gradientColors = [gradientTint.cgColor, gradientHighlight.cgColor, gradientTint.cgColor]
        
        // If the gradient highlight ratio is wide, then it can
        // 'bleed' over into the visible space of the view, which
        // looks particularly bad if there is a pause between the
        // animation repeating.
        // Shifting the start and end points of the gradient by the
        // size of the highlight prevents this.
        gradientLayer.startPoint = CGPoint(x: -gradientHighlightRatio, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1+gradientHighlightRatio, y: 0.5)
        gradientLayer.locations = startLocations
        gradientLayer.colors = gradientColors
        
        let animationKeyPath = "locations"
        
        let shimmerAnimation = CABasicAnimation(keyPath: animationKeyPath)
            shimmerAnimation.fromValue = startLocations
            shimmerAnimation.toValue = endLocations
            shimmerAnimation.duration = animationDuration
            shimmerAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let animationGroup = CAAnimationGroup()
            animationGroup.duration = animationDuration + animationDelay
            animationGroup.repeatCount = .infinity
            animationGroup.animations = [shimmerAnimation]
        
        // Removes animation with same key (if exists) then adds
        // The new animation
        gradientLayer.removeAnimation(forKey: animationKeyPath)
        gradientLayer.add(animationGroup, forKey: animationKeyPath)
    }
}
