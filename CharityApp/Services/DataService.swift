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
    
    func createDBUser(uid: String, userData: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadOrganizationNews(_ news: OrganizationNews, sendComplete: @escaping (_ status: Bool) -> ()) {
        let newsReference = REF_ORGANIZATION_NEWS.childByAutoId()
        news.key = newsReference.key
        newsReference.updateChildValues(news.convertToSnapshot())
        sendComplete(true)
    }
    
    func uploadProject(_ project: Project, sendComplete: @escaping (_ status: Bool) -> ()) {
        let newsReference = REF_ORGANIZATION_NEWS.childByAutoId()
        project.key = newsReference.key
        newsReference.updateChildValues(project.convertToSnapshot())
        sendComplete(true)
    }
    
    func uploadProjectNews(_ news: ProjectNews, for project: Project, sendComplete: @escaping (_ status: Bool) -> ()) {
        if let projectKey = project.key {
            // TODO: Check in Sasha's brach if string is right
            let newsReference = REF_PROJECTS.child(projectKey).child("news").childByAutoId()
            news.key = newsReference.key
            newsReference.updateChildValues(news.convertToSnapshot())
            sendComplete(true)
        } else {
            sendComplete(false)
        }
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
    
    func getAllOrganizationNews(handler: @escaping (_ news: [News]) -> ()) {
        var news = [News]()
        REF_ORGANIZATION_NEWS.observeSingleEvent(of: .value) { (newsSnapshot) in
            guard let newsSnapshot = newsSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            for pieceOfNewsSnaphot in newsSnapshot {
                let pieceOfNews = OrganizationNews(snapshot: pieceOfNewsSnaphot)
                news.append(pieceOfNews)
            }

            handler(news)
        }
    }
}
