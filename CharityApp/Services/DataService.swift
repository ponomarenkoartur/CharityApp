//
//  DataService.swift
//  CharityApp
//
//  Created by Artur on 5/19/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference().child("Example22")

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_PROJECTS = DB_BASE.child("charityNeeds")
    private var _REF_ORGANIZATION_NEWS = DB_BASE.child("organizationNews")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_PROJECTS: DatabaseReference {
        return _REF_PROJECTS
    }
    
    var REF_ORGANIZATION_NEWS: DatabaseReference {
        return _REF_ORGANIZATION_NEWS
    }
    
    var currentUser: User?
    
    func createDBUser(uid: String, userData: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    // MARK: - Organization news
    
    func uploadOrganizationNews(_ news: OrganizationNews, sendComplete: @escaping (_ status: Bool) -> ()) {
        let newsReference = REF_ORGANIZATION_NEWS.childByAutoId()
        news.key = newsReference.key
        newsReference.updateChildValues(news.convertToSnapshot())
        sendComplete(true)
    }
    
    func uploadProjectNews(_ news: ProjectNews, for project: Project, sendComplete: @escaping (_ status: Bool) -> ()) {
        if let projectKey = project.key {
            let newsReference = REF_PROJECTS.child(projectKey).child("news").childByAutoId()
            news.key = newsReference.key
            newsReference.updateChildValues(news.convertToSnapshot())
            sendComplete(true)
        } else {
            sendComplete(false)
        }
    }
    
    func getAllOrganizationNews(handler: @escaping (_ newsCollection: [OrganizationNews]) -> ()) {
        var newsCollection = [OrganizationNews]()
        REF_ORGANIZATION_NEWS.observeSingleEvent(of: .value) { (newsCollectionSnapshot) in
            guard let newsCollectionSnapshot = newsCollectionSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            for newsSnaphot in newsCollectionSnapshot {
                let news = OrganizationNews(snapshot: newsSnaphot)
                newsCollection.append(news)
            }
            
            handler(newsCollection)
        }
    }
    
    func removeOrganizationNews(_ news: OrganizationNews, deleteComplete: @escaping (_ status: Bool) -> ()) {
        if let key = news.key {
            REF_ORGANIZATION_NEWS.child(key).removeValue()
            deleteComplete(true)
        } else {
            deleteComplete(false)
        }
    }
    
    func updateOrganizationNews(_ news: OrganizationNews, updateComplete: @escaping (_ status: Bool) -> ()) {
        if let key = news.key {
            REF_ORGANIZATION_NEWS.child(key).updateChildValues(news.convertToSnapshot())
            updateComplete(true)
        } else {
            updateComplete(false)
        }
    }
    
    func updateLikeCountOrganizationNews(_ news: News) {
        if let key = news.key {
            REF_ORGANIZATION_NEWS.child(key).child("likes").setValue(news.likesCount)
        }
    }
    
    // MARK: - Projects
    
    func uploadProject(_ project: Project, sendComplete: @escaping (_ status: Bool) -> ()) {
        let newsReference = REF_PROJECTS.childByAutoId()
        project.key = newsReference.key
        newsReference.updateChildValues(project.convertToSnapshot())
        sendComplete(true)
    }
    
    
    func getAllProjects(handler: @escaping (_ projects: [Project]) -> ()) {
        var projects = [Project]()
        REF_PROJECTS.observeSingleEvent(of: .value) { (projectsSnapshot) in
            guard let projectsSnapshot = projectsSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            for projectSnapshot in projectsSnapshot {
                let project = Project(snapshot: projectSnapshot)
                projects.append(project)
            }
            
            handler(projects)
        }
    }
    
    func removeProject(_ project: Project, deleteComplete: @escaping (_ status: Bool) -> ()) {
        if let key = project.key {
            REF_PROJECTS.child(key).removeValue()
            deleteComplete(true)
        } else {
            deleteComplete(false)
        }
    }

    func updateProject(_ project: Project, updateComplete: @escaping (_ status: Bool) -> ()) {
        if let key = project.key {
            REF_PROJECTS.child(key).updateChildValues(project.convertToSnapshot())
            updateComplete(true)
        } else {
            updateComplete(false)
        }
    }
    
    // MARK: - User
    
    func getCurrentUser(handler: @escaping (_ user: User?) -> ()) {
        if let currentUser = Auth.auth().currentUser {
            REF_USERS.child(currentUser.uid).observeSingleEvent(of: .value) { (userSnapshot) in
                let user = User(snapshot: userSnapshot)
                handler(user)
            }
        } else {
            handler(nil)
        }
    }
    
    func addLikedOrganizationNewsToUser(_ news: OrganizationNews, user: User, handler: @escaping (_ result: Bool) -> ()) {
        if let key = user.key {
            REF_USERS.child(key).child("likedOrganizationNews").observeSingleEvent(of: .value) { (snapshot) in
                var likedNewsString = ""
                if let valueSnapshot = snapshot.value, !(valueSnapshot is NSNull) {
                    likedNewsString = valueSnapshot as! String
                }
                likedNewsString.append(contentsOf: "\(key),")
                self.REF_USERS.child(key).child("likedOrganizationNews").setValue(likedNewsString)
            }
        }
    }
    
    func removeLikedOrganizationNewsFromUser(_ news: OrganizationNews, user: User, handler: @escaping (_ result: Bool) -> ()) {
        if let key = user.key {
            REF_USERS.child(key).child("likedOrganizationNews").observeSingleEvent(of: .value) { (snapshot) in
                var likedNewsString = ""
                if let valueSnapshot = snapshot.value, !(valueSnapshot is NSNull) {
                    likedNewsString = valueSnapshot as! String
                }
                likedNewsString = likedNewsString.replacingOccurrences(of: "\(key),", with: "")
                self.REF_USERS.child(key).child("likedOrganizationNews").setValue(likedNewsString)
            }
        }
    }
}
