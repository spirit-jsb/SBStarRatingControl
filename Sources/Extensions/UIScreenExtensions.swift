//
//  UIScreenExtensions.swift
//  SBStarRatingControl
//
//  Created by JONO-Jsb on 2023/7/26.
//

#if canImport(UIKit)

import UIKit

extension UIScreen {
    static var current: UIScreen {
        if #available(iOS 16.0, *), let screen = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).last?.screen {
            return screen
        } else {
            return UIScreen.main
        }
    }
}

#endif
