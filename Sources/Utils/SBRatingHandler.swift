//
//  SBRatingHandler.swift
//  SBStarRatingControl
//
//  Created by JONO-Jsb on 2023/7/25.
//

#if canImport(Foundation)

import Foundation

struct SBRatingHandler {
    static func displayedRatingFromPreciseRating(_ preciseRating: Float, totalStars: Int, fillMode: SBStarRatingControl.Configuration.FillMode) -> Float {
        let integerPartOfRating = floor(preciseRating)
        let remainderOfRating = preciseRating - integerPartOfRating

        var displayedRating = integerPartOfRating + self.starFillLevel(rating: remainderOfRating, fillMode: fillMode)
        // Can't go bigger than number of stars & Can't be less than zero
        displayedRating = max(min(displayedRating, Float(totalStars)), 0.0)

        return displayedRating
    }

    static func starFillLevel(rating: Float, fillMode: SBStarRatingControl.Configuration.FillMode) -> Float {
        var starFillLevel = rating < 0.0 ? 0.0 : rating > 1.0 ? 1.0 : rating

        switch fillMode {
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
