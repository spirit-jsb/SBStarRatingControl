//
//  FillModeExtensions.swift
//  SBStarRatingControl
//
//  Created by JONO-Jsb on 2023/8/2.
//

#if canImport(UIKit)

import UIKit

extension SBStarRatingControl.Configuration.FillMode {
    func starFillLevel(rating: Float) -> Float {
        var starFillLevel = rating < 0.0 ? 0.0 : rating > 1.0 ? 1.0 : rating

        switch self {
            case .full:
                starFillLevel = round(starFillLevel)
            case .half:
                starFillLevel = round(starFillLevel * 2.0) / 2.0
            case .precise:
                break
        }

        return starFillLevel
    }
}

#endif
