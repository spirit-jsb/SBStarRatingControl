//
//  SBStarLayerFactory.swift
//  SBStarRatingControl
//
//  Created by JONO-Jsb on 2023/7/26.
//

#if canImport(UIKit)

import UIKit

struct SBStarLayerFactory {
    static func createStarLayers(configuration: SBStarRatingControl.Configuration, rating: Float, isRightToLeft: Bool) -> [CALayer] {
        var remainderOfRating = max(min(rating, Float(configuration.totalStars)), 0.0)

        var starLayers = [CALayer]()
        (0 ..< configuration.totalStars).forEach { _ in
            let fillLevel = SBRatingHandler.starFillLevel(rating: remainderOfRating, fillMode: configuration.fillMode)

            let compositeStarLayer = self.createCompositeStarLayer(configuration: configuration, fillLevel: fillLevel, isRightToLeft: isRightToLeft)
            starLayers.append(compositeStarLayer)

            remainderOfRating -= 1.0
        }

        if isRightToLeft {
            starLayers.reverse()
        }

        self.positionStarLayers(starLayers, starSpacing: configuration.starSpacing)

        return starLayers
    }

    static func createStarLayer(size: CGFloat, fillColor: UIColor?, strokeColor: UIColor?, lineWidth: CGFloat) -> CALayer {
        let starContainerLayer = self.starContainerLayer(size: size)

        let starPath = self.starPath(size: size)
        let starShapeLayer = self.starShapeLayer(path: starPath, size: size, fillColor: fillColor, strokeColor: strokeColor, lineWidth: lineWidth)

        starContainerLayer.addSublayer(starShapeLayer)

        return starContainerLayer
    }

    static func createStarLayer(image: UIImage?, size: CGFloat, tintColor: UIColor?) -> CALayer {
        let starContainerLayer = self.starContainerLayer(size: size)

        let starImageContainerLayer = self.starContainerLayer(size: size)

        if let tintColor = tintColor {
            let starMaskImageContainerLayer = self.starContainerLayer(size: size)
            starMaskImageContainerLayer.contents = image?.cgImage
            starMaskImageContainerLayer.contentsGravity = .resizeAspect

            starImageContainerLayer.mask = starMaskImageContainerLayer
            starImageContainerLayer.backgroundColor = tintColor.cgColor
        } else {
            starImageContainerLayer.contents = image?.cgImage
            starImageContainerLayer.contentsGravity = .resizeAspect
        }

        starContainerLayer.addSublayer(starImageContainerLayer)

        return starContainerLayer
    }

    private static func createCompositeStarLayer(configuration: SBStarRatingControl.Configuration, fillLevel: Float, isRightToLeft: Bool) -> CALayer {
        if fillLevel >= 1.0 {
            return self.starLayer(configuration: configuration, isFilled: true)
        }

        if fillLevel == 0.0 {
            return self.starLayer(configuration: configuration, isFilled: false)
        }

        return self.preciseStarLayer(configuration: configuration, fillLevel: fillLevel, isRightToLeft: isRightToLeft)
    }

    private static func positionStarLayers(_ starLayers: [CALayer], starSpacing: CGFloat) {
        var positionX: CGFloat = 0.0

        for layer in starLayers {
            layer.position.x = positionX
            positionX += layer.bounds.width + starSpacing
        }
    }

    private static func starLayer(configuration: SBStarRatingControl.Configuration, isFilled: Bool) -> CALayer {
        let starSize = configuration.starSize

        let backgroundColor = isFilled ? configuration.filledBackgroundColor : configuration.emptyBackgroundColor

        let borderColor = isFilled ? configuration.filledBorderColor : configuration.emptyBorderColor
        let borderWidth = isFilled ? configuration.filledBorderWidth : configuration.emptyBorderWidth

        let image = isFilled ? configuration.filledImage : configuration.emptyImage
        let imageTintColor = isFilled ? configuration.filledImageTintColor : configuration.emptyImageTintColor

        return image != nil ? self.createStarLayer(image: image, size: starSize, tintColor: imageTintColor) : self.createStarLayer(size: starSize, fillColor: backgroundColor, strokeColor: borderColor, lineWidth: borderWidth)
    }

    private static func preciseStarLayer(configuration: SBStarRatingControl.Configuration, fillLevel: Float, isRightToLeft: Bool) -> CALayer {
        let emptyStarLayer = self.starLayer(configuration: configuration, isFilled: false)
        let filledStarLayer = self.starLayer(configuration: configuration, isFilled: true)

        let preciseStarLayer = CALayer()
        preciseStarLayer.bounds = CGRect(x: 0.0, y: 0.0, width: filledStarLayer.bounds.width, height: filledStarLayer.bounds.height)
        preciseStarLayer.anchorPoint = CGPoint()
        preciseStarLayer.contentsScale = UIScreen.current.scale

        preciseStarLayer.addSublayer(emptyStarLayer)
        preciseStarLayer.addSublayer(filledStarLayer)

        if isRightToLeft {
            filledStarLayer.transform = CATransform3DTranslate(CATransform3DMakeRotation(.pi, 0.0, 1.0, 0.0), -filledStarLayer.bounds.width, 0.0, 0.0)
        }

        filledStarLayer.bounds.size.width *= CGFloat(fillLevel)

        return preciseStarLayer
    }

    private static func starContainerLayer(size: CGFloat) -> CALayer {
        let layer = CALayer()
        layer.bounds.size = CGSize(width: size, height: size)
        layer.anchorPoint = CGPoint()
        layer.masksToBounds = true
        layer.contentsScale = UIScreen.current.scale
        layer.isOpaque = true
        return layer
    }

    private static func starPath(size: CGFloat) -> CGPath {
        // https://www.hackingwithswift.com/quick-start/swiftui/how-to-draw-polygons-and-stars
        let corners = 5
        let smoothness: CGFloat = 0.382

        // draw from the center of our rectangle
        let center = CGPoint(x: size / 2.0, y: size / 2.0)

        // start from directly upwards (as opposed to down or to the right)
        var currentAngle = -CGFloat.pi / 2.0

        // calculate how much we need to move with each star corner
        let angleAdjustment = CGFloat.pi * 2.0 / CGFloat(corners * 2)

        // figure out how much we need to move X/Y for the inner points of the star
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness

        // we're ready to start with our path now
        let path = UIBezierPath()

        // move to our initial position
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))

        // track the lowest point we draw to, so we can center later
        var bottomEdge: CGFloat = 0.0

        // loop over all our points/inner points
        for corner in 0 ..< corners * 2 {
            // figure out the location of this point
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: CGFloat

            // if we're a multiple of 2 we are drawing the outer edge of the star
            if corner.isMultiple(of: 2) {
                // store this Y position
                bottom = center.y * sinAngle

                // and add a line to there
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                // we're not a multiple of 2, which means we're drawing an inner point

                // store this Y position
                bottom = innerY * sinAngle

                // and add a line to there
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }

            // if this new bottom point is our lowest, stash it away for later
            if bottom > bottomEdge {
                bottomEdge = bottom
            }

            currentAngle += angleAdjustment
        }

        // close path
        path.close()

        // figure out how much unused space we have at the bottom of our drawing rectangle
        let unusedSpace = (size / 2.0 - bottomEdge) / 2.0

        // create and apply a transform that moves our path down by that amount, centering the shape vertically
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        path.apply(transform)

        return path.cgPath
    }

    private static func starShapeLayer(path: CGPath, size: CGFloat, fillColor: UIColor?, strokeColor: UIColor?, lineWidth: CGFloat) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.bounds.size = CGSize(width: size, height: size)
        layer.anchorPoint = CGPoint()
        layer.masksToBounds = true
        layer.contentsScale = UIScreen.current.scale
        layer.isOpaque = true

        layer.path = path
        layer.fillColor = fillColor?.cgColor
        layer.strokeColor = strokeColor?.cgColor
        layer.lineWidth = ceil(lineWidth * UIScreen.current.scale) / UIScreen.current.scale

        return layer
    }
}

#endif
