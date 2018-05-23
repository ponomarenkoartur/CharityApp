//
//  AuthService.swift
//  CharityApp
//
//  Created by Artur on 5/19/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(_ user: User, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (userInDatabase, error) in
            guard let userInDatabase = userInDatabase else {
                userCreationComplete(false, error)
                return
            }
            
            DataService.instance.createDBUser(uid: userInDatabase.uid, userData: user.getSnapshot())
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping (_ status: Bool, _ errorCode: AuthErrorCode?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard let _ = user else {
                if let error = error as NSError? {
                    let errorCode = AuthErrorCode(rawValue: error.code)
                    loginComplete(false, errorCode)
                }
                return
            }
            loginComplete(true, nil)
        }
    }
}

