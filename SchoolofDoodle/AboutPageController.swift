//
//  AboutPageController.swift
//  SchoolofDoodle
//
//  Created by Hannah Scott '17 on 7/21/16.
//  Copyright © 2016 Hannah Scott '17. All rights reserved.
//

import UIKit
import Firebase

class AboutPageController: UIViewController {
    
    let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
    
    let logoImageView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage(named: "SchoolofDoodleLogo")
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.contentMode = .ScaleAspectFill
        return logoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        navigationItem.title = "About"
        view.addSubview(logoImageView)
        
        //Constraints for ImageView; need x, y, width, heigth constraints
        logoImageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        logoImageView.widthAnchor.constraintEqualToConstant(75).active = true
        logoImageView.heightAnchor.constraintEqualToConstant(75).active = true
        logoImageView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -275).active = true
        
        //Text
        let aboutUsLabel: UILabel = UILabel()
        aboutUsLabel.frame = CGRectMake(25, 115, 400, 25)
        aboutUsLabel.textColor = UIColor(r: 255, g: 48, b: 241)
        aboutUsLabel.font = UIFont(name: "BlackTinBox", size: 30.0)
        aboutUsLabel.textAlignment = NSTextAlignment.Left
        aboutUsLabel.text = "About Us"
        self.view.addSubview(aboutUsLabel)
        
        let aboutUsTextLabel: UILabel = UILabel()
        aboutUsTextLabel.frame = CGRectMake(25, 0, 325, 400)
        aboutUsTextLabel.textColor = UIColor.blackColor()
        aboutUsTextLabel.numberOfLines = 8
        aboutUsTextLabel.font = UIFont.systemFontOfSize(12)
        aboutUsTextLabel.textAlignment = NSTextAlignment.Left
        aboutUsTextLabel.text = "School of Doodle is a space that offers all of you girls knowledge, skills and experiences not taught in high school, and, we believe, will close the Confidence Gap. What does that mean? World domination and future success on your terms! An extracurricular activity that complements rather than replaces formal education, School of Doodle’s simple goal is to give you the tools to BE LOUD!"
        self.view.addSubview(aboutUsTextLabel)
        
        let aboutAppLabel: UILabel = UILabel()
        aboutAppLabel.frame = CGRectMake(25, 275, 400, 25)
        aboutAppLabel.textColor = UIColor(r: 255, g: 48, b: 241)
        aboutAppLabel.font = UIFont(name: "BlackTinBox", size: 30.0)
        aboutAppLabel.textAlignment = NSTextAlignment.Left
        aboutAppLabel.text = "What's This App For?"
        self.view.addSubview(aboutAppLabel)
        
        let aboutAppTextLabel: UILabel = UILabel()
        aboutAppTextLabel.frame = CGRectMake(25, 140, 325, 400)
        aboutAppTextLabel.textColor = UIColor.blackColor()
        aboutAppTextLabel.numberOfLines = 5
        aboutAppTextLabel.font = UIFont.systemFontOfSize(12)
        aboutAppTextLabel.textAlignment = NSTextAlignment.Left
        aboutAppTextLabel.text = "The School of Doodle app is a platform for girls to connect with other girls over similar interests. Collaborate on an art project, form a punk rock band, and/or achieve world domination with your Doodle sisters!"
        self.view.addSubview(aboutAppTextLabel)
        
        let howItWorksLabel: UILabel = UILabel()
        howItWorksLabel.frame = CGRectMake(25, 395, 400, 25)
        howItWorksLabel.textColor = UIColor(r: 255, g: 48, b: 241)
        howItWorksLabel.font = UIFont(name: "BlackTinBox", size: 30.0)
        howItWorksLabel.textAlignment = NSTextAlignment.Left
        howItWorksLabel.text = "How it Works"
        self.view.addSubview(howItWorksLabel)
        
        let howItWorksTextLabel: UILabel = UILabel()
        howItWorksTextLabel.frame = CGRectMake(25, 300, 325, 400)
        howItWorksTextLabel.textColor = UIColor.blackColor()
        howItWorksTextLabel.numberOfLines = 15
        howItWorksTextLabel.font = UIFont.systemFontOfSize(12)
        howItWorksTextLabel.textAlignment = NSTextAlignment.Left
        howItWorksTextLabel.text = "1) Head over to the 'My Profile' section to add your personal information. \n \n2) Click the Home Screen to see your feed of other Doodlers who share your interests. \n \n3) Tap a girl's profile to learn more and/or message them. \n \n4) Use the search feautre to look up user profiles. \n \nHave fun!"
        self.view.addSubview(howItWorksTextLabel)
        
        let image = UIImage(named: "Search")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .Plain, target: self, action: #selector(handleSearch))
        
        let imageTwo = UIImage(named: "Channel")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageTwo, style: .Plain, target: self, action: nil)
    
    }
    
    func handleSearch(){
        presentViewController(SearchController(), animated: true, completion: nil)
    }
    
//Adds scrolling
    override func loadView() {
        // calling self.view later on will return a UIView!, but we can simply call
        // self.scrollView to adjust properties of the scroll view:
        self.view = self.scrollView
        
        // setup the scroll view
        self.scrollView.contentSize = CGSize(width: 300, height: 1000)
        // etc...
    }
    
    func example() {
        let sampleSubView = UIView()
        self.view.addSubview(sampleSubView) // adds to the scroll view
        
        // cannot do this:
        // self.view.contentOffset = CGPoint(x: 10, y: 20)
        // so instead we do this:
        self.scrollView.contentOffset = CGPoint(x: 10, y: 20)
    }


}