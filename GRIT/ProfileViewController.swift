//
//  ProfileViewController.swift
//  GRIT
//
//  Created by Jared Williams on 9/28/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import Foundation
import UIKit


class ProfileViewController: UIViewController {
    
    
    private var doneButton: UIBarButtonItem!
    private var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.title = "Profile View"
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButtonPressed))
        self.navigationItem.rightBarButtonItem = self.doneButton
        
        self.profileImageView = UIImageView(frame: CGRect(x: 8, y: 75, width: 75, height: 75))
        self.profileImageView.image = #imageLiteral(resourceName: "jared")
        self.profileImageView.clipsToBounds = true
        self.profileImageView.contentMode = .scaleAspectFill
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        self.profileImageView.translatesAutoresizingMaskIntoConstraints = true
        
        self.view.addSubview(self.profileImageView)
        
        
        
        self.setupConstraints()
        
    }
    
    @objc func doneButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupConstraints() {
        self.profileImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -20).isActive = true
        self.profileImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8).isActive = true
    }
}
