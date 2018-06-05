//
//  DataService.swift
//  CharityApp
//
//  Created by Artur on 5/19/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference().child("Example")

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_PROJECTS = DB_BASE.child("charityNeeds")
    private var _REF_ORGANIZATION_NEWS = DB_BASE.child("organizationNews")
    private var _REF_ORGANIZATION_INFO = DB_BASE.child("organizationInfo")
    
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
    
    var REF_ORGANIZATION_INFO: DatabaseReference {
        return _REF_ORGANIZATION_INFO
    }
    
    var currentUser: User?
    
    func createDBUser(uid: String, userData: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    // MARK: - Organization
    
    func getOrganization(handler: @escaping (_ organization: Organization) -> ()) {
        REF_ORGANIZATION_INFO.observeSingleEvent(of: .value) { (snapshot) in
            let organizaton = Organization(snaphot: snapshot)
            handler(organizaton)
        }
    }
    
    // MARK: - Organization news
    
    func uploadOrganizationNews(_ news: OrganizationNews, sendComplete: @escaping (_ status: Bool) -> ()) {
        let newsReference = REF_ORGANIZATION_NEWS.childByAutoId()
        news.key = newsReference.key
        newsReference.updateChildValues(news.convertToSnapshot())
        sendComplete(true)
        NotificationSenderService.instance.sendNotification(withTopic: "OrganizationNews", newsId: news.key!, newsTitle: news.title, newsText: news.text)
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
    
    // MARK: - Project News
    
    func getAllNewsOfProject(_ project: Project, handler: @escaping (_ projectsNewsCollection: [ProjectNews]) -> ()) {
        var newsCollection = [ProjectNews]()
        if let projectKey = project.key {
            REF_PROJECTS.child(projectKey).child("news").observeSingleEvent(of: .value) { (newsCollectionSnapshot) in
                guard let newsCollectionSnapshot = newsCollectionSnapshot.children.allObjects as? [DataSnapshot] else {
                    return
                }
                
                for newsSnaphot in newsCollectionSnapshot {
                    let news = ProjectNews(snapshot: newsSnaphot)
                    newsCollection.append(news)
                }
                
                handler(newsCollection)
            }
        }
    }
    
    func uploadProjectNews(_ news: ProjectNews, ofProject project: Project, sendComplete: @escaping (_ status: Bool) -> ()) {
        if let projectKey = project.key {
            let newsReference = REF_PROJECTS.child(projectKey).child("news").childByAutoId()
            news.key = newsReference.key
            newsReference.updateChildValues(news.convertToSnapshot())
            sendComplete(true)
        } else {
            sendComplete(false)
        }
    }
    
    func removeProjectNews(_ news: ProjectNews, ofProject project: Project, deleteComplete: @escaping (_ status: Bool) -> ()) {
        if let newsKey = news.key, let projectKey = project.key {
            REF_PROJECTS.child(projectKey).child("news").child(newsKey).removeValue()
            deleteComplete(true)
        } else {
            deleteComplete(false)
        }
    }
    
    func updateProjectNews(_ news: ProjectNews, ofProject project: Project, updateComplete: @escaping (_ status: Bool) -> ()) {
        guard let projectKey = project.key, let newsKey = news.key else {
            updateComplete(false)
            return
        }
        REF_PROJECTS.child(projectKey).child("news").child(newsKey).updateChildValues(news.convertToSnapshot())
        updateComplete(true)
    }
    
    func getAllProjectNews(handler: @escaping (_ newsCollection: [ProjectNews]) -> ()) {
        var newsCollection = [ProjectNews]()
        
        REF_PROJECTS.observeSingleEvent(of: .value) { (projectsSnapshot) in
            guard let projectsSnapshot = projectsSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            for projectSnapshot in projectsSnapshot {
                guard let newsCollectionSnapshot = projectSnapshot.childSnapshot(forPath: "news").children.allObjects as? [DataSnapshot] else {
                    return
                }
                
                let projectKey = projectSnapshot.childSnapshot(forPath: "charityNeedKey").value as! String
                let projectTitle = projectSnapshot.childSnapshot(forPath: "title").value as! String
                
                for newsSnapshot in newsCollectionSnapshot {
                    let news = ProjectNews(snapshot: newsSnapshot)
                    news.parentProjectKey = projectKey
                    news.parentProjectTitle = projectTitle
                    newsCollection.append(news)
                }
            }
            
            handler(newsCollection)
        }
    }

    // MARK: - News
    
    func getAllNews(handler: @escaping (_ newsCollection: [News]) -> ()) {
        var newsCollection = [News]()
        getAllOrganizationNews { (organizationNewsCollection) in
            newsCollection.append(contentsOf: organizationNewsCollection)
            
            self.getAllProjectNews(handler: { (projectNewsCollection) in
                newsCollection.append(contentsOf: projectNewsCollection)
                
                handler(newsCollection)
            })
        }
    }
    
    private func updateLikeCountOfNews(_ news: News, ofProjectWithKey projectKey: String?) {
        guard let newsKey = news.key  else {
            return
        }
        if news is ProjectNews,
            let projectKey = projectKey {
            // Update likeCount of project news
            REF_PROJECTS.child(projectKey).child("news").child(newsKey).child("likes").setValue(news.likesCount)
        } else {
            // Update likeCount of organization news
            REF_ORGANIZATION_NEWS.child(newsKey).child("likes").setValue(news.likesCount)
        }
    }
    
    private func updateLikeCountOfNews(_ news: News, ofProject project: Project?) {
        updateLikeCountOfNews(news, ofProjectWithKey: project?.key)
    }
    
    // MARK: - Projects
    
    func getProjectByKey(_ key: String, handler: @escaping (_ project: Project) -> ()) {
        REF_PROJECTS.observeSingleEvent(of: .value) { (projectsSnapshot) in
            guard let projectsSnapshot = projectsSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            for projectSnapshot in projectsSnapshot {
                let projectKey = projectSnapshot.childSnapshot(forPath: "charityNeedKey").value as! String
                if projectKey == key {
                    let project = Project(snapshot: projectSnapshot)
                    handler(project)
                    break
                }
            }
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
    
    
    func uploadProject(_ project: Project, sendComplete: @escaping (_ status: Bool) -> ()) {
        let newsReference = REF_PROJECTS.childByAutoId()
        project.key = newsReference.key
        newsReference.updateChildValues(project.convertToSnapshot())
        sendComplete(true)
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
    
    func likeNews(_ news: News, ofProject project: Project?, byUser user: User, handler: @escaping (_ result: Bool) -> ()) {
        likeNews(news, ofProjectWithKey: project?.key, byUser: user) { (status) in
            handler(status)
        }
    }
    
    func likeNews(_ news: News, ofProjectWithKey projectKey: String?, byUser user: User, handler: @escaping (_ result: Bool) -> ()) {
        guard let userKey = user.key, let newsKey = news.key  else {
            handler(false)
            return
        }
        self.updateLikeCountOfNews(news, ofProjectWithKey: projectKey)
        
        if news is OrganizationNews {
            // Check if "likedOrganizationNews" already has a value
            REF_USERS.child(userKey).child("likedOrganizationNews").observeSingleEvent(of: .value) { (snapshot) in
                var likedNewsString = ""
                if let valueSnapshot = snapshot.value, !(valueSnapshot is NSNull) {
                    likedNewsString = valueSnapshot as! String
                }
                likedNewsString.append(contentsOf: "\(newsKey),")
                self.REF_USERS.child(userKey).child("likedOrganizationNews").setValue(likedNewsString)
                handler(true)
            }
        } else if news is ProjectNews,
            let projectKey = projectKey {
            // Check if "likedNewsPosts" for certain projectKey already has a value
            REF_USERS.child(userKey).child("likedNewsPosts").child(projectKey).observeSingleEvent(of: .value) { (snapshot) in
                var likedNewsString = ""
                if let valueSnapshot = snapshot.value, !(valueSnapshot is NSNull) {
                    likedNewsString = valueSnapshot as! String
                }
                likedNewsString.append(contentsOf: "\(newsKey),")
                self.REF_USERS.child(userKey).child("likedNewsPosts").child(projectKey).setValue(likedNewsString)
                handler(true)
            }
        }
    }
    
    func unlikeNews(_ news: News, ofProject project: Project?, byUser user: User, handler: @escaping (_ result: Bool) -> ()) {
        unlikeNews(news, ofProjectWithKey: project?.key, byUser: user) { (status) in
            handler(status)
        }
    }
    
    func unlikeNews(_ news: News, ofProjectWithKey projectKey: String?, byUser user: User, handler: @escaping (_ result: Bool) -> ()) {
        guard let userKey = user.key, let newsKey = news.key  else {
            handler(false)
            return
        }
        self.updateLikeCountOfNews(news, ofProjectWithKey: projectKey)
        if news is OrganizationNews {
            REF_USERS.child(userKey).child("likedOrganizationNews").observeSingleEvent(of: .value) { (snapshot) in
                var likedNewsString = ""
                if let valueSnapshot = snapshot.value, !(valueSnapshot is NSNull) {
                    likedNewsString = valueSnapshot as! String
                }
                likedNewsString = likedNewsString.replacingOccurrences(of: "\(newsKey),", with: "")
                self.REF_USERS.child(userKey).child("likedOrganizationNews").setValue(likedNewsString)
                handler(true)
            }
        } else if news is ProjectNews,
            let projectKey = projectKey {
            // Check if "likedNewsPosts" for certain projectKey already has a value
            REF_USERS.child(userKey).child("likedNewsPosts").child(projectKey).observeSingleEvent(of: .value) { (snapshot) in
                var likedNewsString = ""
                if let valueSnapshot = snapshot.value, !(valueSnapshot is NSNull) {
                    likedNewsString = valueSnapshot as! String
                }
                likedNewsString = likedNewsString.replacingOccurrences(of: "\(newsKey),", with: "")
                self.REF_USERS.child(userKey).child("likedNewsPosts").child(projectKey).setValue(likedNewsString)
                handler(true)
            }
        }
    }
    
    func subcribeUser(_ user: User, toProject project: Project, handler: @escaping (_ result: Bool) -> ()) {
        if let userKey = user.key, let projectKey = project.key {
            REF_USERS.child(userKey).child("subcribedNeeds").observeSingleEvent(of: .value) { (snapshot) in
                var subcribedProjectsKeysString = ""
                if let valueSnapshot = snapshot.value, !(valueSnapshot is NSNull) {
                    subcribedProjectsKeysString = valueSnapshot as! String
                }
                subcribedProjectsKeysString.append(contentsOf: "\(projectKey),")
                self.REF_USERS.child(userKey).child("subcribedNeeds").setValue(subcribedProjectsKeysString)
                handler(true)
            }
        } else {
            handler(false)
        }
    }
    
    func unsubcribeUser(_ user: User, fromProject project: Project, handler: @escaping (_ result: Bool) -> ()) {
        if let userKey = user.key, let projectKey = project.key {
            REF_USERS.child(userKey).child("subcribedNeeds").observeSingleEvent(of: .value) { (snapshot) in
                var subcribedProjectsKeysString = ""
                if let valueSnapshot = snapshot.value, !(valueSnapshot is NSNull) {
                    subcribedProjectsKeysString = valueSnapshot as! String
                }
                subcribedProjectsKeysString = subcribedProjectsKeysString.replacingOccurrences(of: "\(projectKey),", with: "")
                self.REF_USERS.child(userKey).child("subcribedNeeds").setValue(subcribedProjectsKeysString)
                handler(true)
            }
        } else {
            handler(false)
        }
    }
}
