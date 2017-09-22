//
//  SignUpViewController.swift
//  GRIT
//
//  Created by Taha Topiwala on 3/30/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    let scrollView = UIScrollView()
    let xPositionOffSet : CGFloat = 15
    var textViewPlaceholderText = ""
    @IBOutlet weak var baseView: RoundBorderUIView!
    
    
    
    fileprivate var textFieldFirstname: UITextField!
    fileprivate var textFieldLastname: UITextField!
    fileprivate var textFieldAge: UITextField! // This will have to be changed to a picker view
    fileprivate var textFieldEmail: UITextField!
    fileprivate var textFieldPassword: UITextField!
    fileprivate var textViewInterests: UITextView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.setUpBaseView()
    }
    
    func setUpBaseView() {
        
        
        // These text fields are going to pose a problem when we try to finish sign in. The method attatched to the SignUp button will be called but wont have access to these text fields. They should be declared as class properties
        
        scrollView.frame = CGRect(x: 0, y: 0, width: baseView.frame.width, height: baseView.frame.height)
        
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: baseView.frame.width, height: 60))
        let textlabel = getLabel(previousView: spacerView, tag: 0, title: "Sign up")
        
        self.textFieldFirstname = getTextField(previousView: textlabel, tag: 1, title: "Firstname")
        self.textFieldLastname = getTextField(previousView: textFieldFirstname, tag: 2, title: "Lastname")
        self.textFieldAge = getTextField(previousView: textFieldLastname, tag: 3, title: "Age")
        self.textFieldEmail = getTextField(previousView: textFieldAge, tag: 4, title: "Email")
        self.textFieldPassword = getTextField(previousView: textFieldEmail, tag: 5, title: "Password")
        self.textFieldPassword.isSecureTextEntry = true
        
        self.textViewInterests = getTextView(previousView: textFieldPassword, height: 150, tag: 6, title: "Please type in your interests")
        
        let button = getButton(previousView: textViewInterests, title: "Sign Up")
        
        scrollView.addSubview(textlabel)
        scrollView.addSubview(textFieldFirstname)
        scrollView.addSubview(textFieldLastname)
        scrollView.addSubview(textFieldAge)
        scrollView.addSubview(textFieldEmail)
        scrollView.addSubview(textFieldPassword)
        scrollView.addSubview(textViewInterests)
        scrollView.addSubview(button)
        
        guard let lastElementY = scrollView.subviews.last else {return}
        
        scrollView.contentSize = CGSize(width: baseView.frame.width, height: lastElementY.frame.maxY + 20)
        scrollView.showsVerticalScrollIndicator = false
        
        self.baseView.addSubview(scrollView)
    }
    
    func getTextField(previousView : UIView?, tag: Int, title: String) -> UITextField {
        var yPosition : CGFloat = 20
        if previousView != nil {
            yPosition = (previousView?.frame.maxY)! + 20
        }
        
        let textField = UITextField(frame: CGRect(x: xPositionOffSet, y: yPosition, width: self.baseView.frame.width - (xPositionOffSet * 2), height: 40))
        textField.placeholder = title
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        textField.tag = tag
        textField.delegate = self
        return textField
    }
    
    func getLabel(previousView : UIView?, tag: Int, title: String) -> UILabel {
        var yPosition : CGFloat = 20
        if previousView != nil {
            yPosition = (previousView?.frame.maxY)! + 20
        }
        let label = UILabel(frame: CGRect(x: xPositionOffSet, y: yPosition, width: self.baseView.frame.width - (xPositionOffSet * 2), height: 40))
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.text = title
        label.tag = tag
        return label
    }
    
    func getTextView(previousView : UIView?, height: CGFloat, tag: Int, title: String) -> UITextView {
        var yPosition : CGFloat = 20
        if previousView != nil {
            yPosition = (previousView?.frame.maxY)! + 20
        }
        
        let textView = UITextView()
        textView.frame = CGRect(x: xPositionOffSet, y: yPosition, width: baseView.frame.width - (2 * xPositionOffSet), height: height)
        textView.delegate = self
        textView.text = title
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textColor = UIColor.lightGray
        textView.isEditable = true
        textView.isSelectable = true
        textView.autocorrectionType = UITextAutocorrectionType.no
        textView.layer.backgroundColor = UIColor.white.cgColor
        textView.layer.cornerRadius = 5.0
        textView.tag = tag
        return textView
    }
    
    func getButton(previousView : UIView?, title: String) -> UIButton {
        var yPosition : CGFloat = 20
        if previousView != nil {
            yPosition = (previousView?.frame.maxY)! + 20
        }
        
        let button = UIButton(type: UIButtonType.system)
        button.frame = CGRect(x: xPositionOffSet, y: yPosition, width: baseView.frame.width - (xPositionOffSet * 2), height: 40)
        button.setTitle(title, for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.addTarget(self, action: #selector(self.signUserUp(_:)), for: UIControlEvents.touchUpInside)
        button.layer.cornerRadius = 10.0
        button.layer.backgroundColor = colorMaster.cgColor
        return button
    }
    
  
}

extension SignUpViewController {
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    func signUserUp(_ sender: UIButton) {
            // This method doesnt have access to the textFields bev=cause they are declared within a function and not as class properties
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if (textField.frame.maxY > (self.scrollView.frame.maxY - 250) && self.scrollView.contentOffset.y == 0) {
            
            /**
                We don't want to offset the content when the user taps on one of the fields at the top of the screen
                that causes content that would not even be obstructed by the keyboard to go to the top of the screen. 
                Thus we should only offset content that will actually be obstrcuted by the keyboard
            **/
            
            let point = CGPoint(x: 0, y: 250)
            self.scrollView.setContentOffset(point, animated: true)
        }
        
        
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
}

extension SignUpViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textViewPlaceholderText = textView.text
            textView.text = nil
            textView.textColor = UIColor.black
            
            if (textView.frame.maxY > self.scrollView.frame.maxY - 250) && self.scrollView.contentOffset.y < 250 {
                let point = CGPoint(x: 0, y: 250)
                self.scrollView.setContentOffset(point, animated: true)

            }
            
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = UIColor.lightGray
            //self.scrollView.contentOffset.y = 0
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
        }
        
        return false
    }
}


