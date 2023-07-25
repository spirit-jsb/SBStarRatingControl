//
//  SBStarRatingControl.swift
//  SBStarRatingControl
//
//  Created by JONO-Jsb on 2023/7/25.
//

#if canImport(UIKit)

import UIKit

public class SBStarRatingControl: UIView {
    public var rating: Float

    public var configuration: Configuration

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
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension SBStarRatingControl {
    struct Configuration {
        public static func `default`() -> Configuration {
            return Configuration()
        }
    }
}

#endif
