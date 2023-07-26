//
//  SBStarRatingControl.swift
//  SBStarRatingControl
//
//  Created by JONO-Jsb on 2023/7/25.
//

#if canImport(UIKit)

import UIKit

public class SBStarRatingControl: UIView {
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
        self.layer.rasterizationScale = UIScreen.main.scale

        self.updateView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateView() {}

    private func updateLayout() {}
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
