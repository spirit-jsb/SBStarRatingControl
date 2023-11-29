//
//  ListRatingTableViewCell.swift
//
//  Created by Max on 2023/10/2
//
//  Copyright © 2023 Max. All rights reserved.
//

import SBStarRatingControl
import UIKit

class RatingListTableViewCell: UITableViewCell {
    lazy var preciseStarRatingControl: SBStarRatingControl = {
        let starRatingControl = SBStarRatingControl()
        starRatingControl.translatesAutoresizingMaskIntoConstraints = false
        starRatingControl.configuration.fillMode = .precise
        starRatingControl.configuration.filledBackgroundColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        starRatingControl.configuration.emptyBorderColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        starRatingControl.configuration.filledBorderColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        starRatingControl.configuration.blockingTouch = true
        return starRatingControl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.constructViewHierarchy()
        self.activateConstraints()
    }

    override func prepareForReuse() {
        self.preciseStarRatingControl.prepareForReuse()
    }

    func updateRating(_ rating: Float) {
        self.preciseStarRatingControl.rating = rating
    }

    private func constructViewHierarchy() {
        self.contentView.addSubview(self.preciseStarRatingControl)
    }

    private func activateConstraints() {
        self.preciseStarRatingControl.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.preciseStarRatingControl.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
}
