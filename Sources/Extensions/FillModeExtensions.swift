//
//  FillModeExtensions.swift
//
//  Created by Max on 2023/10/2
//
//  Copyright © 2023 Max. All rights reserved.
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
