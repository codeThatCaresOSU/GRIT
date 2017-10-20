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
    
    
   
    private var profileImageView: UIImageView!
    private var nameLabel: UILabel!
    private var lineView: UIView!
    private var currentUser: User!
    private var scrollView: UIScrollView!
    private var logoutButton: UIBarButtonItem!
  
    
    
    override func viewDidLoad() {
        self.currentUser = FirebaseManager.sharedInstance.getCurrentUser()
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    

    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        
        
        self.profileImageView = UIImageView()
        self.profileImageView.image = #imageLiteral(resourceName: "jared")
        self.profileImageView.contentMode = .scaleAspectFill
        self.profileImageView.clipsToBounds = true
        self.profileImageView.frame = CGRect(x: 20, y: 30, width: 100, height: 100)
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        //self.profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.nameLabel = UILabel()
        self.nameLabel.text = "\(self.currentUser.firstName!) \(self.currentUser.lastName!)"
        self.nameLabel.font = UIFont.systemFont(ofSize: 15)
        self.nameLabel.textColor = UIColor.lightGray
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.lineView = UIView()
        self.lineView.backgroundColor = UIColor.lightGray
        self.lineView.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView = UIScrollView()
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        self.scrollView.showsVerticalScrollIndicator = false
        
        self.logoutButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.logoutPressed))
        
//
//        let point = CGPoint(x: 0, y:45)
//        self.scrollView.setContentOffset(point, animated: true)
        
        
        self.navigationController?.navigationBar.topItem?.title = self.currentUser.firstName
        
        self.scrollView.addSubview(self.profileImageView)
        self.scrollView.addSubview(self.nameLabel)
        self.scrollView.addSubview(self.lineView)
        
        self.view.addSubview(self.scrollView)
        
        self.navigationItem.rightBarButtonItem = self.logoutButton
        
        self.setupConstraints()
    }
    
    func setupConstraints() {
        
        self.scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.scrollView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.scrollView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        self.scrollView.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
        self.nameLabel.centerXAnchor.constraint(equalTo: self.profileImageView.centerXAnchor).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 10).isActive = true
        
        self.lineView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        self.lineView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8).isActive = true
        self.lineView.widthAnchor.constraint(equalToConstant: self.scrollView.frame.width).isActive = true
        self.lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    @objc func logoutPressed() {
        FirebaseManager.sharedInstance.logout()
    }
}
