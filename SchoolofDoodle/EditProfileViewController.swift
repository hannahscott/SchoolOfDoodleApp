//
//  EditProfileViewController.swift
//  SchoolofDoodle
//
//  Created by Hannah Scott '17 on 8/2/16.
//  Copyright © 2016 Hannah Scott '17. All rights reserved.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var user: Users?
    
    let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
    
    let bioTextView: UITextView = {
        let bio = UITextView()
        bio.font = UIFont.systemFontOfSize(15)
        bio.backgroundColor = UIColor(r: 181, g: 254, b: 255)
        bio.translatesAutoresizingMaskIntoConstraints = false
        bio.keyboardType = UIKeyboardType.Default
        bio.returnKeyType = UIReturnKeyType.Done
        bio.layer.cornerRadius = 5
        return bio
    }()
    
    let names: Array<String> = List.names()
    
    lazy var logoImageView: UIImageView = {
        let logoView = UIImageView()
        logoView.image = UIImage(named: "Wheel")
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.contentMode = .ScaleAspectFill
        logoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        logoView.userInteractionEnabled = true
        return logoView
    }()
    
    lazy var saveDataButton: UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor(r: 255, g: 48, b: 241)
        button.setTitle("Save", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        
        button.addTarget(self, action: #selector(handleSaveUserProfile), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    func handleSaveUserProfile() {
        let ref = FIRDatabase.database().reference().child("bio")
        let childRef = ref.childByAutoId()
        let values = ["text": bioTextView.text!]
        childRef.updateChildValues(values)
    }

    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            
            selectedImageFromPicker = editedImage
            
        } else if let originalImage =
            info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            
            logoImageView.image = selectedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("canceled image")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func handleBack() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setupLogoImageView() {
        //need x, y, width, and height constraints
        logoImageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        logoImageView.widthAnchor.constraintEqualToConstant(100).active = true
        logoImageView.heightAnchor.constraintEqualToConstant(100).active = true
        logoImageView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -265).active = true
    }
    
    func setupSaveDataButton() {
        //need x, y, width, and height constraints
        saveDataButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        saveDataButton.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: 500).active = true
        saveDataButton.widthAnchor.constraintEqualToConstant(100).active = true
        saveDataButton.heightAnchor.constraintEqualToConstant(25).active = true
    }
    
    func setupBioTextView() {
        //need x, y, width, and height constraints
        bioTextView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        bioTextView.widthAnchor.constraintEqualToConstant(335).active = true
        bioTextView.heightAnchor.constraintEqualToConstant(300).active = true
        bioTextView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -15).active = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Edit Profile"
        
        view.addSubview(logoImageView)
        setupLogoImageView()
        view.addSubview(saveDataButton)
        setupSaveDataButton()
        view.addSubview(bioTextView)
        setupBioTextView()
        
        let interestsTextPromptLabel = UILabel(frame: CGRectMake(20, 450, 325, 100))
        interestsTextPromptLabel.font = UIFont.systemFontOfSize(15)
        interestsTextPromptLabel.textColor = UIColor.blackColor()
        interestsTextPromptLabel.text = "What are you interested in?"
        self.view.addSubview(interestsTextPromptLabel)
        
        let tokenView = KSTokenView(frame: CGRect(x: 20, y: 525, width: 335, height: 40))
        tokenView.delegate = self
        tokenView.promptText = "Pick 5: "
        tokenView.placeholder = "type to search"
        tokenView.descriptionText = "Interests"
        tokenView.maxTokenLimit = 5
        tokenView.layer.cornerRadius = 5
        tokenView.style = .Squared
        view.addSubview(tokenView)
        
        let bioTextPromptLabel = UILabel(frame: CGRectMake(20, 100, 325, 100))
        bioTextPromptLabel.font = UIFont.systemFontOfSize(15)
        bioTextPromptLabel.textColor = UIColor.blackColor()
        bioTextPromptLabel.text = "Tell us about yourself!"
        self.view.addSubview(bioTextPromptLabel)
        
        self.view.backgroundColor = UIColor(r: 43, g: 241, b: 255)
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(handleBack))
    }
    
    override func loadView() {
        self.view = self.scrollView
        self.scrollView.contentSize = CGSize(width: 300, height: 1000)
    }
    
    func example() {
        let sampleSubView = UIView()
        self.view.addSubview(sampleSubView)
        self.scrollView.contentOffset = CGPoint(x: 10, y: 20)
    }

}

extension EditProfileViewController: KSTokenViewDelegate {
    func tokenView(token: KSTokenView, performSearchWithString string: String, completion: ((results: Array<AnyObject>) -> Void)?) {
        var data: Array<String> = []
        for value: String in names {
            if value.lowercaseString.rangeOfString(string.lowercaseString) != nil {
                data.append(value)
            }
        }
        completion!(results: data)
    }
    
    func tokenView(token: KSTokenView, displayTitleForObject object: AnyObject) -> String {
        return object as! String
    }
}