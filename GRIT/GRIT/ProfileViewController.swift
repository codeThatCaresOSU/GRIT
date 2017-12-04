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
    private var descriptionView: UITextView!
    private var ageLabel: UILabel!
    private var fromLabel: UILabel!
    private var roleLabel: UILabel!
    private var editButton: UIBarButtonItem!

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
        
        self.descriptionView = UITextView(frame: CGRect(x: 0, y: 0, width: self.scrollView.frame.width - 20, height: 100))
        self.descriptionView.isEditable = false
        self.descriptionView.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionView.text = self.currentUser.description
        self.descriptionView.textAlignment = .natural
        
        self.ageLabel = UILabel()
        self.ageLabel.text = "Age: \(self.currentUser.age!)"
        self.ageLabel.textColor = UIColor.lightGray
        self.ageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.fromLabel = UILabel()
        self.fromLabel.text = "From: Columbus, Ohio"
        self.fromLabel.textColor = UIColor.lightGray
        self.fromLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.roleLabel = UILabel()
        self.roleLabel.text = "Role: Mentor"
        self.roleLabel.textColor = UIColor.lightGray
        self.roleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(self.logoutPressed))
        self.navigationItem.rightBarButtonItem = self.logoutButton
        self.logoutButton.tintColor = UIColor.red
        
        self.editButton = UIBarButtonItem(image: #imageLiteral(resourceName: "editButton"), style: .plain, target: self, action: #selector(self.editPressed))
        self.navigationItem.leftBarButtonItem = self.editButton
        
        self.scrollView.addSubview(self.profileImageView)
        self.scrollView.addSubview(self.ageLabel)
        self.scrollView.addSubview(self.fromLabel)
        self.scrollView.addSubview(self.nameLabel)
        self.scrollView.addSubview(self.lineView)
        self.scrollView.addSubview(self.descriptionView)
        self.scrollView.addSubview(self.roleLabel)
        
        self.view.addSubview(self.scrollView)
    
        
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
        
        self.ageLabel.topAnchor.constraint(equalTo: self.profileImageView.topAnchor, constant: 10).isActive = true
        self.ageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 10).isActive = true
        
        self.fromLabel.topAnchor.constraint(equalTo: self.ageLabel.bottomAnchor, constant: 8).isActive = true
        self.fromLabel.leftAnchor.constraint(equalTo: self.ageLabel.leftAnchor, constant: 0).isActive = true
        
        self.roleLabel.topAnchor.constraint(equalTo: self.fromLabel.bottomAnchor, constant: 8).isActive = true
        self.roleLabel.leftAnchor.constraint(equalTo: self.fromLabel.leftAnchor).isActive = true
        
        
        self.lineView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        self.lineView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 4).isActive = true
        self.lineView.widthAnchor.constraint(equalToConstant: self.scrollView.frame.width).isActive = true
        self.lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.descriptionView.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor).isActive = true
        self.descriptionView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8).isActive = true
        self.descriptionView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: -20).isActive = true
        self.descriptionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @objc func logoutPressed() {
        FirebaseManager.sharedInstance.logout()
        CoredataManager.sharedInstance.deleteUserData()
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "logout"), object: nil))
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func editPressed() {
        print("Edit Button Press Success!")
    }
}
