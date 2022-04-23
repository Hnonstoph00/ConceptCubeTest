//
//  SignUpViewController.swift
//  ConceptCubeTest
//
//  Created by Huy Hà on 4/20/22.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
// - MARK: IBOulets
    @IBOutlet weak var idTextfield: UITextField!
    
    @IBOutlet weak var checkIDButton: UIButton!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var rePasswordTextfield: UITextField!
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    //MARK: -ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        // Do any additional setup after loading the view.
        setupBackgroundTouch()
    }
    
    private func registerUser() {
        User.regiserUserWith(id: idTextfield.text! , password: passwordTextfield.text!, rePassword: rePasswordTextfield.text!, email: emailTextfield.text!, dateOfBirth: birthdayDatePicker.date, completion: {
            error in
            if error == nil {
                self.showAlertGotoLoginView(title: "Congratulation", message: "Sign up successfully")
                
            } else {
                self.showAlert(title: "Opps", message: "Sign up fail")
            }
    
        })
    }
    
    //MARK: - IBActions
    @IBAction func signUpButtonPressed(_ sender: Any) {
        if(checkInputField()){
            if(checkEmailExist()){
                registerUser()
            }
        }
    }
    @IBAction func checkIDButtonPressed(_ sender: Any) {
        let x = checkEmailExist()
        if (x) {
            self.showAlert(title: "Cool", message: "You can use this email")
        }
    }
    
   
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Helper
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            print("Tap Cancel")
        }))
        present(alert, animated: true)
    }
    
    func showAlertGotoLoginView(title: String, message: String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            self.goToLoginView()
        }))
        present(alert, animated: true)
    }
    
    func checkInputField () -> Bool {
        if(idTextfield.text != "" && passwordTextfield.text != "" && rePasswordTextfield.text != "" && emailTextfield.text != "") {
            if let x = passwordTextfield.text, let y = rePasswordTextfield.text {
                if x.count < 6 || y.count < 6 {
                    showAlert(title: "Alert", message: "Password must have at least 6 characters")
                    return false
                }
            }
            if(passwordTextfield.text != rePasswordTextfield.text) {
                showAlert(title: "Alert", message: "You input wrong password")
                passwordTextfield.text = ""
                rePasswordTextfield.text = ""
                return false
            }
            return true
        }
        else {
            showAlert(title: "Alert", message: "All fields must be filled in ")
            return false
        }
    }
    
    func checkEmailExist () ->  Bool{
        var check = true
        let emailAddress = emailTextfield.text!
        let emailPattern = #"^\S+@\S+\.\S+$"#
        var result = emailAddress.range(
            of: emailPattern,
            options: .regularExpression
        )

        let validEmail = (result != nil)
        if (!validEmail) {
            showAlert(title: "alert", message: "Email bad format")
            return false
        }
        Auth.auth().fetchSignInMethods(forEmail: emailAddress, completion: { (stringArray, error) in
            if error != nil {
                self.showAlert(title: "Alert", message: "Something Wrong")
                self.emailTextfield.text = ""
                check = false
            } else {
                if stringArray == nil {
                    
                    check = true
                } else {
                    self.showAlert(title: "Alert", message: "Existing email")
                    self.emailTextfield.text = ""
                    check = false
                }
            }
        })
        return check
    }
    
    func setupBackgroundTouch () {
        self.view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func backgroundTap() {
        dismissKeyboard()
    }
    
    func dismissKeyboard () {
        self.view.endEditing(false)
    }
    func goToLoginView () {
        let loginView = self.storyboard?.instantiateViewController(identifier: "loginView") as! LoginViewController
        loginView.modalPresentationStyle = .fullScreen
        self.present(loginView, animated: true, completion: nil)
    }
}
