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

        public var maxStarCount: Int = 5

        public var fillMode: FillMode = .full

        public var starSize: CGFloat = 20.0

        public var starSpacing: CGFloat = 5.0

        public var emptyBackgroundColor: UIColor? = UIColor.clear

        public var filledBackgroundColor: UIColor? = UIColor(red: 0.0, green: CGFloat(122) / 255.0, blue: 1.0, alpha: 1.0)

        public var emptyBorderColor: UIColor? = UIColor(red: 0.0, green: CGFloat(122) / 255.0, blue: 1.0, alpha: 1.0)
        public var emptyBorderWidth: CGFloat = 1.0

        public var filledBorderColor: UIColor? = UIColor(red: 0.0, green: CGFloat(122) / 255.0, blue: 1.0, alpha: 1.0)
        public var filledBorderWidth: CGFloat = 1.0

        public var emptyImage: UIImage?
        public var emptyColor: UIColor?

        public var filledImage: UIImage?
        public var filledColor: UIColor?

        public var blockingTouch: Bool = false

        public var updateRatingUsingGesture: Bool = true

        public var minRatingUsingGesture: Float = 1.0

        public var isPanGestureEnabled: Bool = true

        public static func `default`() -> Configuration {
            return Configuration()
        }
    }
}

#endif
