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

        var displayedRating = integerPartOfRating + fillMode.starFillLevel(rating: remainderOfRating)
        // Can't go bigger than number of stars & Can't be less than zero
        displayedRating = max(min(displayedRating, Float(totalStars)), 0.0)

        return displayedRating
    }
}

#endif
