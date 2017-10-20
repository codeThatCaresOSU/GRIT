//
//  ViewController.swift
//  GRIT
//
//  Created by Taha Topiwala on 3/29/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        FirebaseManager.sharedInstance.loginUser(email: emailField.text!, password: passwordField.text!) { (user: User) in
            
            // Make sue the viewController presentation is within the completionhandler
            
          
                let nav = UINavigationController(rootViewController: ProfileViewController())
                nav.navigationBar.topItem?.title = user.firstName
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "login"), object: nil))

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    func setupView() {
        self.emailField.delegate = self
        self.passwordField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func doneButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }


}

