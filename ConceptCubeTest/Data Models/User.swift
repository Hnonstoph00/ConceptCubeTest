//
//  User.swift
//  ConceptCubeTest
//
//  Created by Huy Hà on 4/20/22.
//

import Foundation
import Firebase
import UIKit
class User : Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.objectId == rhs.objectId
    }
    
    let objectId : String = ""
    
    //- MARK: Register User
    class func regiserUserWith(id: String, password: String, rePassword: String, email: String, dateOfBirth: Date, completion: @escaping (_ error: Error?) -> Void)  {
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
            completion(error)
            if error == nil {
                if error == nil {
                    authData!.user.sendEmailVerification { (error) in
                    print("Email vertification has sent", error?.localizedDescription)
                    }
                }
            }
            else {
                print("Something error here")
            }
        }
    }
    //-MARK: Login User
    class func loginUserWith(email: String, password: String, completion: @escaping (_ error: Error?) -> Void ) {
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            if error  == nil {
                if authData!.user.isEmailVerified {
                    
                }
            }
            else {
                print("Email wrong")
            }
        }
    }
}
 
