//
//  ListRatingViewController.swift
//  SBStarRatingControl-Demo
//
//  Created by JONO-Jsb on 2023/8/1.
//

import UIKit

class ListRatingViewController: UIViewController {
    @available(iOS 13.0, *)
    lazy var appearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        appearance.backgroundColor = UIColor.clear

        return appearance
    }()

    private var ratings = [Float](repeating: 0.0, count: 100)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.0, green: CGFloat(47) / 255.0, blue: CGFloat(167) / 255.0, alpha: 1.0)
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.standardAppearance = self.appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = self.appearance
        }

        for index in 0 ..< 100 {
            self.ratings[index] = Float(index) / 99.0 * 5.0
        }
    }
}

extension ListRatingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RatingListTableViewCell") as? RatingListTableViewCell {
            let rating = self.ratings[indexPath.row]
            cell.updateRating(rating)

            cell.preciseStarRatingControl.didFinishTouchingStarRating = { [weak self] rating in
                self?.ratings[indexPath.row] = rating
            }

            return cell
        }

        return UITableViewCell()
    }
}
