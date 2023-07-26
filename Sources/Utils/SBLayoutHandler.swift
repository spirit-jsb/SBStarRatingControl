//
//  SBLayoutHandler.swift
//  SBStarRatingControl
//
//  Created by JONO-Jsb on 2023/7/26.
//

#if canImport(UIKit)

import UIKit

struct SBLayoutHandler {
    static func sizeToFitLayers(_ layers: [CALayer]) -> CGSize {
        var size = CGSize()

        for layer in layers {
            if layer.frame.maxX > size.width {
                size.width = layer.frame.maxX
            }
            if layer.frame.maxY > size.height {
                size.height = layer.frame.maxY
            }
        }

        return size
    }
}

#endif
