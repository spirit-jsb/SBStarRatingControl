//
//  UIViewExtensions.swift
//
//  Created by Max on 2023/10/2
//
//  Copyright © 2023 Max. All rights reserved.
//

#if canImport(UIKit)

import UIKit

extension UIView {
    var isRightToLeft: Bool {
        return self.effectiveUserInterfaceLayoutDirection == .rightToLeft
    }
}

#endif
