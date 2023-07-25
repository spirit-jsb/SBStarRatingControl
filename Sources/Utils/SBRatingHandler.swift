//
//  SBRatingHandler.swift
//  SBStarRatingControl
//
//  Created by JONO-Jsb on 2023/7/25.
//

#if canImport(Foundation)

import Foundation

struct SBRatingHandler {
    static func fillLevel(forRating rating: Float, fillMode: SBStarRatingControl.Configuration.FillMode) -> Float {
        var result = rating

        if result > 1.0 {
            result = 1.0
        }
        if result < 0.0 {
            result = 0.0
        }

        switch fillMode {
            case .full:
                result = round(result)
            case .half:
                result = round(result * 2.0) / 2.0
            case .precise:
                break
        }

        return result
    }
}

#endif
