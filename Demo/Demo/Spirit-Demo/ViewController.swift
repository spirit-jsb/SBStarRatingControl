//
//  ViewController.swift
//
//  Created by Max on 2023/10/2
//
//  Copyright © 2023 Max. All rights reserved.
//

import SBStarRatingControl
import UIKit

class ViewController: UIViewController {
    lazy var fullTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Full"
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        label.textColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        return label
    }()

    lazy var fullStarRatingControl: SBStarRatingControl = {
        let starRatingControl = SBStarRatingControl()
        starRatingControl.configuration.emptyBackgroundColor = UIColor(red: CGFloat(242) / 255.0, green: CGFloat(242) / 255.0, blue: CGFloat(242) / 255.0, alpha: 1.0)
        starRatingControl.configuration.filledBackgroundColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        starRatingControl.configuration.emptyBorderColor = UIColor(red: CGFloat(242) / 255.0, green: CGFloat(242) / 255.0, blue: CGFloat(242) / 255.0, alpha: 1.0)
        starRatingControl.configuration.filledBorderColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        return starRatingControl
    }()

    lazy var halfTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Half"
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        label.textColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        return label
    }()

    lazy var halfStarRatingControl: SBStarRatingControl = {
        let starRatingControl = SBStarRatingControl()
        starRatingControl.configuration.fillMode = .half
        starRatingControl.configuration.starSize = 40.0
        starRatingControl.configuration.starSpacing = 8.0
        starRatingControl.configuration.filledBackgroundColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        starRatingControl.configuration.emptyBorderColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        starRatingControl.configuration.filledBorderColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        return starRatingControl
    }()

    lazy var preciseTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Precise"
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        label.textColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        return label
    }()

    lazy var preciseStarRatingControl: SBStarRatingControl = {
        let starRatingControl = SBStarRatingControl()
        starRatingControl.configuration.fillMode = .precise
        starRatingControl.configuration.starSize = 60.0
        starRatingControl.configuration.starSpacing = 11.0
        starRatingControl.configuration.filledBackgroundColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        starRatingControl.configuration.emptyBorderColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        starRatingControl.configuration.emptyBorderWidth = 2.0
        starRatingControl.configuration.filledBorderColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        starRatingControl.configuration.filledBorderWidth = 2.0
        return starRatingControl
    }()

    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        label.textColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        return label
    }()

    lazy var ratingSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = -1.0
        slider.maximumValue = 6.0
        slider.minimumTrackTintColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        slider.maximumTrackTintColor = UIColor(red: CGFloat(242) / 255.0, green: CGFloat(242) / 255.0, blue: CGFloat(242) / 255.0, alpha: 1.0)
        slider.thumbTintColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        slider.addTarget(self, action: #selector(self.ratingChanged(_:)), for: .valueChanged)
        return slider
    }()

    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.fullTitleLabel, self.fullStarRatingControl, self.halfTitleLabel, self.halfStarRatingControl, self.preciseTitleLabel, self.preciseStarRatingControl, self.ratingLabel, self.ratingSlider])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8.0

        stackView.setCustomSpacing(32.0, after: self.fullStarRatingControl)
        stackView.setCustomSpacing(32.0, after: self.halfStarRatingControl)
        stackView.setCustomSpacing(48.0, after: self.preciseStarRatingControl)
        stackView.setCustomSpacing(16.0, after: self.ratingLabel)

        return stackView
    }()

    private let defaultRating: Float = 2.021821

    override func viewDidLoad() {
        super.viewDidLoad()

        self.constructViewHierarchy()
        self.activateConstraints()

        self.fullStarRatingControl.touchRatingChanged = self.touchRatingChanged
        self.halfStarRatingControl.touchRatingChanged = self.touchRatingChanged
        self.preciseStarRatingControl.touchRatingChanged = self.touchRatingChanged

        self.fullStarRatingControl.touchRatingEnded = self.touchRatingEnded
        self.halfStarRatingControl.touchRatingEnded = self.touchRatingEnded
        self.preciseStarRatingControl.touchRatingEnded = self.touchRatingEnded

        self.ratingSlider.value = self.defaultRating

        self.fullStarRatingControl.rating = self.ratingSlider.value
        self.halfStarRatingControl.rating = self.ratingSlider.value
        self.preciseStarRatingControl.rating = self.ratingSlider.value

        self.ratingLabel.text = String(format: "%.2f", self.ratingSlider.value)
    }

    private func constructViewHierarchy() {
        self.view.addSubview(self.contentStackView)
    }

    private func activateConstraints() {
        self.contentStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        self.contentStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        self.ratingSlider.widthAnchor.constraint(equalToConstant: 320.0).isActive = true
    }

    @objc
    func ratingChanged(_ sender: UISlider) {
        self.fullStarRatingControl.rating = self.ratingSlider.value
        self.halfStarRatingControl.rating = self.ratingSlider.value
        self.preciseStarRatingControl.rating = self.ratingSlider.value

        self.ratingLabel.text = String(format: "%.2f", self.ratingSlider.value)
    }

    func touchRatingChanged(_ rating: Float) {
        self.ratingSlider.value = rating

        self.fullStarRatingControl.rating = rating
        self.halfStarRatingControl.rating = rating
        self.preciseStarRatingControl.rating = rating

        self.ratingLabel.text = String(format: "%.2f", rating)
    }

    func touchRatingEnded(_ rating: Float) {
        self.ratingSlider.value = rating
    }
}
