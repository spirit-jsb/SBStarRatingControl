//
//  ImageStarViewController.swift
//  SBStarRatingControl-Demo
//
//  Created by JONO-Jsb on 2023/8/1.
//

import SBStarRatingControl
import UIKit

class ImageStarViewController: UIViewController {
    lazy var imageStarRatingControl: SBStarRatingControl = {
        let starRatingControl = SBStarRatingControl()
        starRatingControl.translatesAutoresizingMaskIntoConstraints = false
        starRatingControl.rating = 2.021829
        starRatingControl.configuration.fillMode = .precise
        starRatingControl.configuration.starSize = 45.0
        starRatingControl.configuration.emptyImage = UIImage(named: "empty_star")
        starRatingControl.configuration.filledImage = UIImage(named: "filled_star")
        return starRatingControl
    }()

    lazy var withTintColorImageStarRatingControl: SBStarRatingControl = {
        let starRatingControl = SBStarRatingControl()
        starRatingControl.translatesAutoresizingMaskIntoConstraints = false
        starRatingControl.rating = 2.021829
        starRatingControl.configuration.starSize = 45.0
        starRatingControl.configuration.emptyImage = UIImage(named: "empty_star")
        starRatingControl.configuration.emptyImageTintColor = UIColor(red: CGFloat(242) / 255.0, green: CGFloat(242) / 255.0, blue: CGFloat(242) / 255.0, alpha: 1.0)
        starRatingControl.configuration.filledImage = UIImage(named: "filled_star")
        starRatingControl.configuration.filledImageTintColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        return starRatingControl
    }()

    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.imageStarRatingControl, self.withTintColorImageStarRatingControl])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 30.0
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.constructViewHierarchy()
        self.activateConstraints()
    }

    private func constructViewHierarchy() {
        self.view.addSubview(self.contentStackView)
    }

    private func activateConstraints() {
        self.contentStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.contentStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}
