//
//  AuthService.swift
//  CharityApp
//
//  Created by Artur on 5/19/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Firebase
import UIKit

class AuthService {
    static let instance = AuthService()
    
    var currentUser: User?
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ errorCode: AuthErrorCode?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (userInDatabase, error) in
            guard let userInDatabase = userInDatabase else {
                if let error = error as NSError? {
                    let errorCode = AuthErrorCode(rawValue: error.code)
                    userCreationComplete(false, errorCode)
                }
                return
            }
            let user = User(key: nil)
            DataService.instance.createDBUser(uid: userInDatabase.uid, userData: user.convertToSnapshot())
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
    
    func logout(handler: @escaping (_ status: Bool) -> ()) {
        do {
            try Auth.auth().signOut()
            currentUser = nil
            handler(true)
        } catch {
            handler(false)
            print(error)
        }
    }
}

