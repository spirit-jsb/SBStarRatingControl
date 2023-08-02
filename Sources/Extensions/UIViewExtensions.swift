//
//  UIViewExtensions.swift
//  SBStarRatingControl
//
//  Created by JONO-Jsb on 2023/7/26.
//

#if canImport(UIKit)

import UIKit

extension UIView {
    var isRightToLeft: Bool {
        return self.effectiveUserInterfaceLayoutDirection == .rightToLeft
    }
}

#endif
