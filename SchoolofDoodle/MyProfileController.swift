//
//  MyProfileController.swift
//  SchoolofDoodle
//
//  Created by Hannah Scott '17 on 7/21/16.
//  Copyright © 2016 Hannah Scott '17. All rights reserved.
//

import UIKit
import Firebase

class MyProfileController: UIViewController {
    
    let logoImageView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage(named: "Wheel")
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.contentMode = .ScaleAspectFill
        return logoView
    }()
    
    var bios = [Bio]()
    
    //Shows Firebase database information for inputted bios in console
    func observeBio() {
        let ref = FIRDatabase.database().reference().child("bio")
        ref.observeEventType(.ChildAdded, withBlock: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let bio = Bio()
                bio.setValuesForKeysWithDictionary(dictionary)
                print(bio.text)
            }
            
            }, withCancelBlock: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(handleLogout))
        let image = UIImage(named: "Search")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .Plain, target: self, action: #selector(handleSearch))
        self.view.backgroundColor = UIColor.whiteColor()

        checkIfUserIsLoggedIn()
        view.addSubview(logoImageView)
        setupLogoImageView()
        observeBio()
        fetchBioTextandSetupBioLabel()
        
        let button = UIButton(frame: CGRect(x: 135, y: 500, width: 100, height: 30))
        button.backgroundColor = UIColor(r: 255, g: 48, b: 241)
        button.layer.cornerRadius = 5
        button.setTitle("Edit Profile", forState: .Normal)
        button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    
    }
    
    func handleSearch(){
        presentViewController(SearchController(), animated: true, completion: nil)
    }
    
    func buttonAction(sender: UIButton!) {
        let navController = UINavigationController(rootViewController: EditProfileViewController())
        self.presentViewController(navController, animated: true, completion: nil)

    }
    
    func setupLogoImageView() {
        //Constraints for Profile Image; need x, y, width, and height constraints
        logoImageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        logoImageView.widthAnchor.constraintEqualToConstant(100).active = true
        logoImageView.heightAnchor.constraintEqualToConstant(100).active = true
        logoImageView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -200).active = true
    }
    
    func checkIfUserIsLoggedIn () {
        //user is not logged in
        if FIRAuth.auth()?.currentUser?.uid == nil {
            performSelector(#selector(handleLogout), withObject: nil, afterDelay: 0)
            handleLogout()
        } else {
            fetchUserAndSetupNavBarTitle()
        }
    }

    func fetchUserAndSetupNavBarTitle() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.navigationItem.title = dictionary["name"] as? String
                
                let nameLabel = UILabel(frame: CGRect(x: 115, y: 200, width: 500, height: 30))
                nameLabel.text = dictionary["name"] as? String
                nameLabel.font = UIFont(name: "BlackTinBox", size: 30.0)
                nameLabel.textColor = UIColor(r: 255, g: 48, b: 241)
                self.view.addSubview(nameLabel)
            }
            
            }, withCancelBlock: nil)
    }
    
    func fetchBioTextandSetupBioLabel() {
        let ref = FIRDatabase.database().reference().child("bio")
        ref.observeEventType(.ChildAdded, withBlock: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let bioText = UILabel(frame: CGRect(x: 0, y: 250, width: 375, height: 30))
                bioText.text = dictionary["text"] as? String
                bioText.textAlignment = .Center
                self.view.addSubview(bioText)
            self.dismissViewControllerAnimated(true, completion: nil)
                
            }
            
            }, withCancelBlock: nil)
        }

    
    func handleLogout() {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginController()
        loginController.myProfileController = self
        presentViewController(loginController, animated: true, completion: nil)
    }
    
}
