//
//  UIViewExtensions.swift
//  Awesome Corners
//
//  Created by Ahmadreza on 9/3/21.
//

import UIKit

enum CornerRadius: CGFloat {
    case superLarge = 25
    case large = 15
    case regular = 10
    case small = 5
    case zero = 0
    case round = -1
}

extension UIView {
    
    func dropShadowAndCornerRadious(_ value: CornerRadius, opacity:Float = 0.1) {
        roundUp(value)
        dropShadow(opacity: opacity, corner: value)
    }

    func dropShadow(opacity:Float = 0.05, corner: CornerRadius) {
        DispatchQueue.main.async { [weak self] in
            self?.layer.masksToBounds = false
            self?.layer.shadowColor = UIColor.black.cgColor
            self?.layer.shadowOpacity = opacity
            self?.layer.shadowOffset = CGSize(width: 5, height: 5)
            if corner == .round {
                self?.layer.shadowRadius = (self?.bounds.height ?? 2) / 8
            } else {
                self?.layer.shadowRadius = corner.rawValue
            }
        }
    }
    
    func roundUp(_ value: CornerRadius) {
        DispatchQueue.main.async { [weak self] in
            if value == .round {
                self?.layer.cornerRadius = (self?.bounds.height ?? 2) / 2
            } else {
                self?.layer.cornerRadius = value.rawValue
            }
            self?.layer.masksToBounds = true
            if #available(iOS 13.0, *) {
                if value != .round {
                    self?.layer.cornerCurve = .continuous
                }
            }
        }
    }
}
