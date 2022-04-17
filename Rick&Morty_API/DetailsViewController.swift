//
//  DetailsViewController.swift
//  Rick&Morty_API
//
//  Created by Adam Khalifa on 16.04.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var numberOfEpisodes: UILabel!

    var name = ""
    var type = ""
    var gender = ""
    var location = ""
    var img = UIImage()
    var number = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        heroImage.layer.cornerRadius = 10
        nameLabel.text = name
        typeLabel.text = type
        genderLabel.text = gender
        locationLabel.text = location
        heroImage.image = img
        numberOfEpisodes.text = number
    }

    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }

    func setGradientBackground() {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
