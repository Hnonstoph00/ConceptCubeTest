//
//  LoginViewController.swift
//  ConceptCubeTest
//
//  Created by Huy Hà on 4/20/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    //-MARK:IBOutlets
    @IBOutlet weak var idTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
   
    //-MARK:ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundTouch()
        // Do any additional setup after loading the view.
    }
    func checkLoginFields () {
        if( idTextfield.text != "" && passwordTextfield.text != "") {
            
        }
        else {
            showAlert(title: "Alert" , message: "All fields must be filled in")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            print("Tap Cancel")
        }))
        present(alert, animated: true)
    }
    
    //-MARK:IBActions
    
    @IBAction func signUp(_ sender: Any) {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        checkLoginFields()
        guard
          let email = idTextfield.text,
          let password = passwordTextfield.text,
          !email.isEmpty,
          !password.isEmpty
        else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error, user == nil {
                let alert = UIAlertController(
                  title: "Pasword or email is wrong",
                  message: error.localizedDescription,
                  preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
              }
            else {
                self.goToMainView()
            }
        }
    }
    //MARK: Helper
    func goToMainView () {
        let mainView = self.storyboard?.instantiateViewController(identifier: "Mainview") as! MainViewController
        mainView.modalPresentationStyle = .fullScreen
        self.present(mainView, animated: true, completion: nil)
    }
    
    private func setupBackgroundTouch () {
        self.view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func backgroundTap() {
        dismissKeyboard()
    }
    private func dismissKeyboard () {
        self.view.endEditing(false)
    }
    
}
