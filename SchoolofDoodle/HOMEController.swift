//
//  ViewController.swift
//  SchoolofDoodle
//
//  Created by Hannah Scott '17 on 7/15/16.
//  Copyright © 2016 Hannah Scott '17. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {
    
    let cellId = "cellId"
    
    var users = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        let image = UIImage(named: "Search")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .Plain, target: self, action: #selector(handleSearch))
        
        let imageTwo = UIImage(named: "Channel")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageTwo, style: .Plain, target: self, action: nil)
        
        tableView.registerClass(UserCell.self, forCellReuseIdentifier: cellId)
        
        fetchUser()
    }
    
    func handleSearch(){
        presentViewController(SearchController(), animated: true, completion: nil)
    }
    
    //Presents messages contorller (NewMessageController)
    func handleNewMessage() {
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        presentViewController(navController, animated: true, completion: nil)
    }
    
    //Pulls users from Firebase Database and lists them in Table View
    func fetchUser() {
        FIRDatabase.database().reference().child("users").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = Users()
                user.setValuesForKeysWithDictionary(dictionary)
                self.users.append(user)
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
                
                //user.name = dictionary["name"]
            }
            
            }, withCancelBlock: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        
        return cell
    }
}

class UserCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
