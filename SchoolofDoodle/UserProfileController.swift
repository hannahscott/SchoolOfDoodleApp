//
//  UserProfileController.swift
//  SchoolofDoodle
//
//  Created by Hannah Scott '17 on 8/4/16.
//  Copyright © 2016 Hannah Scott '17. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let detailDescriptionLabel: UILabel! = {
        let detailLabel = UILabel()
        detailLabel.text = "test"
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        return detailLabel
    }()
    
    let candyImageView: UIImageView! = {
        let candyImage = UIImageView()
        candyImage.image = UIImage(named: "SchoolofDoodleLogo")
        candyImage.translatesAutoresizingMaskIntoConstraints = false
        candyImage.contentMode = .ScaleAspectFill
        return candyImage
    }()
    
    var detailCandy: Users? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let detailCandy = detailCandy {
            if let detailDescriptionLabel = detailDescriptionLabel, candyImageView = candyImageView {
                detailDescriptionLabel.text = detailCandy.name
                candyImageView.image = UIImage(named: detailCandy.name!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

