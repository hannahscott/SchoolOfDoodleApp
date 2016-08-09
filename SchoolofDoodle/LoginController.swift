//
//  LoginController.swift
//  SchoolofDoodle
//
//  Created by Hannah Scott '17 on 7/15/16.
//  Copyright © 2016 Hannah Scott '17. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    var messagesController: MessagesController?
    var myProfileController: MyProfileController?
    
    let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loginRegister: UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor(r: 43, g: 241, b: 255)
        button.setTitle("Register", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        
        button.addTarget(self, action: #selector(handleLoginRegister), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    func handleLogin() {
        guard let email = emailTextField.text, password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
            if error != nil {
                print(error)
                return
            }
            
            //successfully logged in
            self.myProfileController?.fetchUserAndSetupNavBarTitle()
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })
    }
    
    func handleRegister() {
        guard let email = emailTextField.text, password = passwordTextField.text, name = nameTextField.text else {
            print("Form is not valid")
            return
        }
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user: FIRUser?, error) in
            
            if error != nil{
                print(error)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            //successfully authenticated user
            let ref = FIRDatabase.database().referenceFromURL("https://schoolofdoodle.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["name": name, "email": email]
            
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil {
                    print(err)
                    return
                }
                
                self.myProfileController?.fetchUserAndSetupNavBarTitle()
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            })
            
            })
    }
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocapitalizationType = .None
        return tf
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.secureTextEntry = true
        tf.autocapitalizationType = .None
        return tf
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SchoolofDoodleLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor(r: 43, g: 241, b: 255)
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), forControlEvents: .ValueChanged)
        return sc
    }()
    
    func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegmentAtIndex(loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegister.setTitle(title, forState: .Normal)
        
        //change height of inputContainerView
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        //change height of nameTextField
        emailTextFieldHeightAnchor?.active = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
            emailTextFieldHeightAnchor?.active = true
        
        nameTextFieldHeightAnchor?.active = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.active = true
        
        passwordTextFieldHeightAnchor?.active = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.active = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r: 255, g: 48, b: 241)

        view.addSubview(inputsContainerView)
        view.addSubview(loginRegister)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedControl)
        
        setupInputsContainerView()
        setupLoginRegister()
        setupProfileImageView()
        setupLoginRegisterSegmentedControl()
    }
    
    func setupLoginRegisterSegmentedControl() {
        //need x, y, width, and height constraints
        loginRegisterSegmentedControl.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginRegisterSegmentedControl.centerYAnchor.constraintEqualToAnchor(inputsContainerView.topAnchor, constant: -24).active = true
        loginRegisterSegmentedControl.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        loginRegisterSegmentedControl.heightAnchor.constraintEqualToConstant(36).active = true
    }
    
    func setupProfileImageView() {
        //need x, y, width, and height constraints
        profileImageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        profileImageView.bottomAnchor.constraintEqualToAnchor(loginRegisterSegmentedControl.topAnchor, constant: -24).active = true
        profileImageView.widthAnchor.constraintEqualToConstant(150).active = true
        profileImageView.heightAnchor.constraintEqualToConstant(150).active = true
    }
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    func setupInputsContainerView() {
        //need x, y, width, and height constraints
        
        inputsContainerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        inputsContainerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        inputsContainerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -24).active = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraintEqualToConstant(150)
            inputsContainerViewHeightAnchor?.active = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        //need x, y, width, and height constraints
        nameTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        nameTextField.topAnchor.constraintEqualToAnchor(inputsContainerView.topAnchor).active = true
        nameTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.active = true
        
        //need x, y, width, and height constraints
        nameSeparatorView.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor).active = true
        nameSeparatorView.topAnchor.constraintEqualToAnchor(nameTextField.bottomAnchor).active = true
        nameSeparatorView.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        nameSeparatorView.heightAnchor.constraintEqualToConstant(1).active = true
        
        //need x, y, width, and height constraints
        emailTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        emailTextField.topAnchor.constraintEqualToAnchor(nameTextField.bottomAnchor).active = true
        emailTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3)
            emailTextFieldHeightAnchor?.active = true
        
        //need x, y, width, and height constraints
        emailSeparatorView.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor).active = true
        emailSeparatorView.topAnchor.constraintEqualToAnchor(emailTextField.bottomAnchor).active = true
        emailSeparatorView.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        emailSeparatorView.heightAnchor.constraintEqualToConstant(1).active = true
        
        //need x, y, width, and height constraints
        passwordTextField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        passwordTextField.topAnchor.constraintEqualToAnchor(emailTextField.bottomAnchor).active = true
        passwordTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3)
            passwordTextFieldHeightAnchor?.active = true
    }
    
    func setupLoginRegister() {
        //need x, y, width, and height constraints
        loginRegister.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginRegister.topAnchor.constraintEqualToAnchor(inputsContainerView.bottomAnchor, constant: 12).active = true
        loginRegister.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        loginRegister.heightAnchor.constraintEqualToConstant(50).active = true
        
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func loadView() {
        // calling self.view later on will return a UIView!, but we can simply call
        // self.scrollView to adjust properties of the scroll view:
        self.view = self.scrollView
        
        // setup the scroll view
        self.scrollView.contentSize = CGSize(width: 300, height: 500)
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

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}