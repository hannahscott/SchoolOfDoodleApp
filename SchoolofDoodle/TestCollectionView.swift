//
//  TestCollectionView.swift
//  SchoolofDoodle
//
//  Created by Hannah Scott '17 on 8/4/16.
//  Copyright © 2016 Hannah Scott '17. All rights reserved.
//

import UIKit
import Firebase

let customCellIdentifier = "customCellIdentifier"

class TestCollectionView: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.redColor()
        collectionView?.registerClass(CustomCell.self, forCellWithReuseIdentifier: customCellIdentifier)
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCellWithReuseIdentifier(customCellIdentifier, forIndexPath: indexPath)
        return customCell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}

class CustomCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "CustomText"
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nameLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}