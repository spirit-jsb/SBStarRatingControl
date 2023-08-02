//
//  SBStarRatingControl.swift
//  SBStarRatingControl
//
//  Created by JONO-Jsb on 2023/7/25.
//

#if canImport(UIKit)

import UIKit

public class SBStarRatingControl: UIView {
    public var touchRatingChanged: ((Float) -> Void)?
    public var touchRatingEnded: ((Float) -> Void)?

    public var rating: Float {
        didSet {
            if oldValue != self.rating {
                self.updateView()
            }
        }
    }

    public var configuration: Configuration {
        didSet {
            self.updateView()
        }
    }

    private var contentSize: CGSize = .init()

    private var previousRating: Float = -2023.725

    private var optimizeHitBounds: CGRect {
        let recommendedHitSize: CGFloat = 44.0

        var expandHitWidth: CGFloat = recommendedHitSize - self.bounds.width
        var expandHitHeight: CGFloat = recommendedHitSize - self.bounds.height

        expandHitWidth = max(expandHitWidth, 0.0)
        expandHitHeight = max(expandHitHeight, 0.0)

        let expandHitBounds: CGRect = self.bounds.insetBy(dx: -expandHitWidth / 2.0, dy: -expandHitHeight / 2.0)

        return expandHitBounds
    }

    public convenience init(configuration: Configuration) {
        self.init(frame: .zero, configuration: configuration)
    }

    override public convenience init(frame: CGRect) {
        self.init(frame: frame, configuration: Configuration.default())
    }

    init(frame: CGRect, configuration: Configuration) {
        self.rating = 1.0
        self.configuration = configuration

        super.init(frame: frame)

        // https://developer.apple.com/documentation/quartzcore/calayer/1410905-shouldrasterize
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.current.scale

        self.updateView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public var intrinsicContentSize: CGSize {
        return self.contentSize
    }

    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return self.optimizeHitBounds.contains(point)
    }

    override public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.configuration.isPanGestureEnabled ? true : !(gestureRecognizer is UIPanGestureRecognizer)
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.configuration.blockingTouch {
            super.touchesBegan(touches, with: event)
        }

        guard let location = self.touchLocationFromBeginningOfRating(touches) else {
            return
        }

        self.onDidTouch(location)
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.configuration.blockingTouch {
            super.touchesMoved(touches, with: event)
        }

        guard let location = self.touchLocationFromBeginningOfRating(touches) else {
            return
        }

        self.onDidTouch(location)
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.configuration.blockingTouch {
            super.touchesEnded(touches, with: event)
        }

        self.touchRatingEnded?(self.rating)
    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.configuration.blockingTouch {
            super.touchesCancelled(touches, with: event)
        }

        self.touchRatingEnded?(self.rating)
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                self.updateView()
            }
        }
    }

    public func prepareForReuse() {
        self.previousRating = -2023.725
    }

    private func updateView() {
        let starLayers = SBStarLayerFactory.createStarLayers(configuration: self.configuration, rating: self.rating, isRightToLeft: self.isRightToLeft)

        let contentSize = self.sizeToFitLayers(starLayers)

        self.layer.sublayers = starLayers
        self.frame.size = contentSize

        self.contentSize = contentSize

        self.invalidateIntrinsicContentSize()
    }

    private func touchLocationFromBeginningOfRating(_ touches: Set<UITouch>) -> CGFloat? {
        guard let touch = touches.first else {
            return nil
        }

        var location = touch.location(in: self).x

        if self.isRightToLeft {
            location = self.bounds.width - location
        }

        return location
    }

    private func onDidTouch(_ position: CGFloat) {
        let touchRating = SBTouchHandler.touchRating(position: position, configuration: self.configuration)

        if self.configuration.updateRatingUsingGesture {
            self.rating = touchRating
        }

        guard touchRating != self.previousRating else {
            return
        }

        self.touchRatingChanged?(touchRating)

        self.previousRating = touchRating
    }

    private func sizeToFitLayers(_ layers: [CALayer]) -> CGSize {
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

public extension SBStarRatingControl {
    struct Configuration {
        public enum FillMode {
            case full
            case half
            case precise
        }

        public var totalStars: Int

        public var fillMode: FillMode

        public var starSize: CGFloat

        public var starSpacing: CGFloat

        public var emptyBackgroundColor: UIColor?

        public var filledBackgroundColor: UIColor?

        public var emptyBorderColor: UIColor?
        public var emptyBorderWidth: CGFloat

        public var filledBorderColor: UIColor?
        public var filledBorderWidth: CGFloat

        public var emptyImage: UIImage?
        public var emptyImageTintColor: UIColor?

        public var filledImage: UIImage?
        public var filledImageTintColor: UIColor?

        public var blockingTouch: Bool

        public var updateRatingUsingGesture: Bool

        public var minRatingUsingGesture: Float

        public var isPanGestureEnabled: Bool

        init() {
            self.totalStars = 5

            self.fillMode = .full

            self.starSize = 20.0

            self.starSpacing = 5.0

            self.emptyBackgroundColor = UIColor.clear

            self.filledBackgroundColor = UIColor(red: 0.0, green: CGFloat(122) / 255.0, blue: 1.0, alpha: 1.0)

            self.emptyBorderColor = UIColor(red: 0.0, green: CGFloat(122) / 255.0, blue: 1.0, alpha: 1.0)
            self.emptyBorderWidth = 1.0

            self.filledBorderColor = UIColor(red: 0.0, green: CGFloat(122) / 255.0, blue: 1.0, alpha: 1.0)
            self.filledBorderWidth = 1.0

            self.blockingTouch = false

            self.updateRatingUsingGesture = true

            self.minRatingUsingGesture = 1.0

            self.isPanGestureEnabled = true
        }

        public static func `default`() -> Configuration {
            return Configuration()
        }
    }
}

#endif
