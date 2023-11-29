//
//  UIScreenExtensions.swift
//
//  Created by Max on 2023/10/2
//
//  Copyright © 2023 Max. All rights reserved.
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
