//
//  SBTouchHandler.swift
//  SBStarRatingControl
//
//  Created by JONO-Jsb on 2023/7/26.
//

#if canImport(UIKit)

import UIKit

struct SBTouchHandler {
    static func optimizeHitBounds(_ bounds: CGRect) -> CGRect {
        let recommendedHitSize: CGFloat = 44.0

        var expandHitWidth: CGFloat = recommendedHitSize - bounds.width
        var expandHitHeight: CGFloat = recommendedHitSize - bounds.height

        expandHitWidth = max(expandHitWidth, 0.0)
        expandHitHeight = max(expandHitHeight, 0.0)

        let expandHitBounds: CGRect = bounds.insetBy(dx: -expandHitWidth / 2.0, dy: -expandHitHeight / 2.0)

        return expandHitBounds
    }

    static func touchRating(position: CGFloat, configuration: SBStarRatingControl.Configuration) -> Float {
        func preciseTouchRating(position: CGFloat, totalStars: Int, starSize: CGFloat, starSpacing: CGFloat) -> Float {
            guard position >= 0.0 else {
                return 0.0
            }

            var remainderOfPosition = position

            var rating = Float(Int(position / (starSize + starSpacing)))

            guard Int(rating) <= totalStars else {
                return Float(totalStars)
            }

            remainderOfPosition -= CGFloat(rating) * (starSize + starSpacing)

            if remainderOfPosition > starSize {
                rating += Float(1.0)
            } else {
                rating += Float(remainderOfPosition / starSize)
            }

            return rating
        }

        var preciseRating = preciseTouchRating(position: position, totalStars: configuration.totalStars, starSize: configuration.starSize, starSpacing: configuration.starSpacing)

        // sensitivity threshold value = 0.05
        if configuration.fillMode == .half {
            preciseRating += 0.20
        }
        if configuration.fillMode == .full {
            preciseRating += 0.45
        }

        var displayedRating = SBRatingHandler.displayedRatingFromPreciseRating(preciseRating, totalStars: configuration.totalStars, fillMode: configuration.fillMode)

        // Can't be less than min rating
        displayedRating = max(displayedRating, configuration.minRatingUsingGesture)

        return displayedRating
    }
}

#endif
