//
//  ShimmerLabel.swift
//  ShimmerLabelV2
//
//  Created by Rafia on 03/02/2023.
//

import UIKit

public class ShimmerLabel: UILabel {
    public var titleText : String?
    // MARK: - Life cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.autoShirmering()
    }
}
extension UIView {
    private func startShimmering() {
        //        let light = UIColor.init(white: 0, alpha: 0.1).cgColor
        let light = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        let dark = UIColor.black.cgColor

        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [dark, light, dark]
        gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3*self.bounds.size.width, height: self.bounds.size.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.525)
        gradient.locations = [0.4, 0.5, 0.6]
        self.layer.mask = gradient

        let animation: CABasicAnimation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]

        animation.duration = 1.5
        animation.repeatCount = HUGE
        gradient.add(animation, forKey: "shimmer")


    }

    private func stopShimmering() {
        self.layer.mask = nil
    }
    
    public func autoShirmering() {
        self.startShimmering()
        // After 3 seconds shimmering will be stoped
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(1.4)), execute: {
            self.stopShimmering()
            // When Shimmering is stoped after 3 seconds it will again restart and this will go recursive way
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(1.4)), execute: {
                self.autoShirmering()
            })
        })
    }

}


