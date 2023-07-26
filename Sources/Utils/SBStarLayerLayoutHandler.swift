//
//  SBStarLayerLayoutHandler.swift
//  SBStarRatingControl
//
//  Created by JONO-Jsb on 2023/7/26.
//

#if canImport(UIKit)

import UIKit

struct SBStarLayerLayoutHandler {
    static func contentSize(starLayers: [CALayer]) -> CGSize {
        var result = CGSize()

        for layer in starLayers {
            if layer.frame.maxX > result.width {
                result.width = layer.frame.maxX
            }
            if layer.frame.maxY > result.height {
                result.height = layer.frame.maxY
            }
        }

        return result
    }
}

#endif
