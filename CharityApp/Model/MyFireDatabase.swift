//
//  MyFireDataBase.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Firebase
import FirebaseDatabase

//class MyFireDatabase {
//    
//    // MARK: - Constants
//    
//    // MARK: Organization
//    static let CHARITY_NEEDS_ROOT = "charityNeeds"
//    static let ORGANIZATION_INFO_ROOT = "organizationInfo"
//    static let ORGANIZATION_NEWS_ROOT = "organizationNews"
//    
//    // MARK: CHARITY_NEEDS_ROOT
//    static let NEEDS_IMAGE_URLS_ROOT = "imageUrls";
//    static let NEEDS_TAGS_ROOT = "tags";
//    static let NEEDS_NEWS_ROOT = "news";
//    
//    // MARK: ORGANIZATION_NEWS_ROOT
//    static let NEWS_IMAGE_URLS_ROOT = "imageUrls";
//    
//    // MARK: - Properties
//    
//    let root = Database.database().reference()
//}
//
//extension MyFireDatabase: IDatabase {
//    
//    // MARK: - Organization
//    
//    func addOrganization(_ organization: Organization) {
//        let key = organization.info.name
//        let newsCollection = organization.newsCollection
//        let needsCollection = organization.needsCollection
//        
//        // Make the lists null to prevent adding elements by index keys in database.
//        organization.dropAllLists()
//        
//        // After adding the main organization object we call the add news and needs method to correctly place them in the database.
//        
//        root.child(key).observe(.value) { _ in
//            
//            // ***** add line
//            if let newsCollection = newsCollection {
//                for news in newsCollection.values {
//                    self.addNews(news, toOrganizationWithKey: key)
//                }
//            }
//            if let needCollection = needsCollection {
//                for need in needCollection.values {
//                    self.addNeed(need, toOrganizationWithKey: key)
//                }
//            }
//        }
//        root.child(key).child(MyFireDatabase.ORGANIZATION_INFO_ROOT).setValue(organization.info.convertingPrimitivePropertiesToDictionary())
//    }
//    
//    func deleteOrganization(withKey organizationKey: String) {
//        root.child(organizationKey).setValue(nil)
//    }
//    
//    // MARK: - Need
//    
//    func addNeed(_ need: Need, toOrganizationWithKey organizationKey: String) {
//        root.observeSingleEvent(of: .value) { snapshot in
//            for data in snapshot.value as! [String: Any?] {
//                if let _ = data.value, data.key == organizationKey {
//                    /*
//                     *This means there is such an organization. Proceed with the adding.
//                     */
//                    let needsReference = self.root.child(organizationKey).child(MyFireDatabase.CHARITY_NEEDS_ROOT)
//                    let needKey = needsReference.childByAutoId().key
//                    need.key = needKey
//                    
//                    let imageUrlsCollection = need.imageUrlsCollection
//                    let tagsCollection = need.tagsCollection
//                    let needNewsCollection = need.newsCollection
//                    need.dropAllListData()
//                    needsReference.child(needKey).observe(.value, with: { _ in
//                            // ***** add line
//                        
//                        if let imageUrlsCollection = imageUrlsCollection {
//                            for imageUrl in imageUrlsCollection.values {
//                                needsReference.child(needKey).child(MyFireDatabase.NEEDS_IMAGE_URLS_ROOT).childByAutoId().setValue(imageUrl)
//                            }
//                        }
//                        if let tagsCollection = tagsCollection {
//                            for tag in tagsCollection.values {
//                                needsReference.child(needKey).child(MyFireDatabase.NEEDS_TAGS_ROOT).childByAutoId().setValue(tag)
//                            }
//                        }
//                        
//                        if let needNewsCollection = needNewsCollection {
//                            for news in needNewsCollection.values {
//                                self.addNews(news, toOrganizationWithKey: organizationKey, toNeedWithKey: needKey)
//                            }
//                        }
//                    })
//                    
//                    needsReference.child(needKey).setValue(need.convertingPrimitivePropertiesToDictionary())
//                }
//            }
//        }
//    }
//    
//    func updateNeed(_ need: Need, toOrganizationWithKey organizationKey: String) {
//        
//    }
//    
//    func deleteNeed(withKey needKey: String, toOrganizationWithKey organizationKey: String) {
//        root.child(organizationKey).child(MyFireDatabase.CHARITY_NEEDS_ROOT).child(needKey).setValue(nil)
//    }
//    
//    func getNeedsFromOrganization(withKey organizationKey: String, to listener: IDatabaseResultListener) {
//        let reference = Database.database().reference().root.child(organizationKey).child(MyFireDatabase.CHARITY_NEEDS_ROOT)
//        retrieveNeedsCollectionFrom(reference, to: listener)
////        retrieveInfoItemsListFrom(reference, to: listener)
//    }
//    
//    // MARK: - News
//    
//    func addNews(_ news: News, toOrganizationWithKey organizationKey: String) {
//        let target = root.child(organizationKey).child(MyFireDatabase.ORGANIZATION_NEWS_ROOT)
//        addNews(news, to: target)
//    }
//    
//    func addNews(_ news: News, toOrganizationWithKey organizationKey: String, toNeedWithKey needKey: String) {
//        let target = root.child(organizationKey).child(MyFireDatabase.CHARITY_NEEDS_ROOT).child(needKey).child(MyFireDatabase.NEEDS_NEWS_ROOT)
//        addNews(news, to: target)
//    }
//    
//    func getNewsFromOrganizationWithKey(_ organizationKey: String, to listener: IDatabaseResultListener) {
//        let reference = Database.database().reference().root.child(organizationKey).child(MyFireDatabase.ORGANIZATION_NEWS_ROOT)
//        retrieveNewsCollectionFrom(reference, to: listener)
////        retrieveInfoItemsListFrom(reference, to: listener)
//    }
//    
//    // MARK: - Methods
//    
//    private func addNews(_ news: News, to target: DatabaseReference) {
//        let imageUrlsCollection = news.imageUrlsCollection
//        news.dropImageURLs()
//        let newsKey = target.childByAutoId().key
//        news.key = newsKey
//        target.child(newsKey).observe(.value) { _ in
//            if let imageUrlsCollection = imageUrlsCollection {
//                for imageURL in imageUrlsCollection {
//                    target.child(newsKey).child(MyFireDatabase.NEWS_IMAGE_URLS_ROOT).childByAutoId().setValue(imageURL)
//                }
//            }
//        }
//        target.child(newsKey).setValue(news.convertingPrimitivePropertiesToDictionary())
//        target.child(newsKey).child(MyFireDatabase.NEEDS_IMAGE_URLS_ROOT).setValue(imageUrlsCollection)
//    }
//    
//    private func retrieveNewsCollectionFrom(_ newsCollectionReference: DatabaseReference, to listener: IDatabaseResultListener) {
//        newsCollectionReference.observeSingleEvent(of: .value) { snapshot in
//            
//            var newsCollection = [String: News]()
//            for newsSnapshot in snapshot.children {
//                let news = News(snapshot: newsSnapshot as! DataSnapshot)
//                newsCollection[news.key!] = news
//            }
//            
//            listener.onNewsListRetrieved(resultList: newsCollection)
//        }
//    }
//    
//    private func retrieveNeedsCollectionFrom(_ needsCollectionReference: DatabaseReference, to listener: IDatabaseResultListener) {
//        needsCollectionReference.observeSingleEvent(of: .value) { snapshot in
//            
//            var needsCollection = [String: Need]()
//            for needSnapshot in snapshot.children {
//                let need = Need(snapshot: needSnapshot as! DataSnapshot)
//                needsCollection[need.key!] = need
//            }
//            listener.onNeedsListRetrieved(resultList: needsCollection)
//        }
//    }
//}
