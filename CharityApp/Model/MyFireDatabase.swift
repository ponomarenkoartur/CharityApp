//
//  MyFireDataBase.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Firebase
import FirebaseDatabase

class MyFireDatabase {
    
    // MARK: - Constants
    
    // MARK: Organization
    let CHARITY_NEEDS_ROOT = "charityNeeds"
    let ORGANIZATION_INFO_ROOT = "organizationInfo"
    let ORGANIZATION_NEWS_ROOT = "organizationNews"
    
    // MARK: CHARITY_NEEDS_ROOT
    let NEEDS_IMAGE_URLS_ROOT = "imageUrls";
    let NEEDS_TAGS_ROOT = "tags";
    let NEEDS_NEWS_ROOT = "news";
    
    // MARK: ORGANIZATION_NEWS_ROOT
    let NEWS_IMAGE_URLS_ROOT = "imageUrls";
    
    // MARK: - Properties
    
    let root = Database.database().reference()
    
    // MARK: - Methods
    
    private func addNews(_ news: News, to target: DatabaseReference) {
        let imageURLs = news.imageURLs
        news.dropImageURLs()
        let newsKey = target.childByAutoId().key
        news.key = newsKey
        target.child(newsKey).observe(.value) { _ in
            if let imageURLs = imageURLs {
                for imageURL in imageURLs {
                    target.child(newsKey).child(self.NEWS_IMAGE_URLS_ROOT).childByAutoId().setValue(imageURL)
                }
            }
        }
        target.child(newsKey).setValue(news.primitivePropertiesToDictionary())
        target.child(newsKey).child(NEEDS_IMAGE_URLS_ROOT).setValue(imageURLs)
    }
    
    private func retrieveInfoItemsListFrom(_ reference: DatabaseReference, to listener: IDatabaseResultListener) {
        reference.observeSingleEvent(of: .value) { dataSnapshot in
            var newsList = [InfoItem]()
            for snapshot in dataSnapshot.children{
                let item = snapshot as! InfoItem
                newsList.append(item)
            }
            
            listener.onInfoItemsListRetrieved(resultList: newsList)
        }
    }
}

extension MyFireDatabase: IDatabase {
    
    // MARK: - Organization
    
    func addOrganization(_ organization: Organization) {
        let organizationKey = organization.info.name
        let organizationNews = organization.news
        let organizationNeeds = organization.needs
        
        // Make the lists null to prevent adding elements by index keys in database.
        organization.needs = nil
        organization.news = nil
        
        // After adding the main organization object we call the add news and needs method to correctly place them in the database.
        
        root.child(organizationKey).observe(.value) { _ in
            
            // ***** add line
            if let organizationNews = organizationNews {
                for news in organizationNews.values {
                    self.addNews(news, toOrganizationWithKey: organizationKey)
                }
            }
            if let organizationNeeds = organizationNeeds {
                for need in organizationNeeds.values {
                    self.addNeed(need, toOrganizationWithKey: organizationKey)
                }
            }
        }
        root.child(organizationKey).child(ORGANIZATION_INFO_ROOT).setValue(organization.info.primitivePropertiesToDictionary())
        
    }
    
    func deleteOrganizationWithKey(_ organizationKey: String) {
        root.child(organizationKey).setValue(nil)
    }
    
    // MARK: - Need
    
    func addNeed(_ need: Need, toOrganizationWithKey organizationKey: String) {
        root.observeSingleEvent(of: .value) { snapshot in
            for data in snapshot.value as! [String: Any?] {
                if let _ = data.value, data.key == organizationKey {
                    /*
                     *This means there is such an organization. Proceed with the adding.
                     */
                    let needsReference = self.root.child(organizationKey).child(self.CHARITY_NEEDS_ROOT)
                    let needKey = needsReference.childByAutoId().key
                    need.key = needKey
                    
                    let imageURLs = need.imageURLs
                    let tags = need.tags
                    let needNews = need.news
                    need.dropAllListData()
                    needsReference.child(needKey).observe(.value, with: { _ in
                            // ***** add line
                        
                        if let imageURLs = imageURLs {
                            for URL in imageURLs.values {
                                needsReference.child(needKey).child(self.NEEDS_IMAGE_URLS_ROOT).childByAutoId().setValue(URL)
                            }
                        }
                        if let tags = tags {
                            for tag in tags.values {
                                needsReference.child(needKey).child(self.NEEDS_TAGS_ROOT).childByAutoId().setValue(tag)
                            }
                        }
                        
                        if let needNews = needNews {
                            for news in needNews.values {
                                self.addNews(news, toOrganizationWithKey: organizationKey, toNeedWithKey: needKey)
                            }
                        }
                    })
                    
                    needsReference.child(needKey).setValue(need.primitivePropertiesToDictionary())
                }
            }
        }
    }
    
    func updateNeed(_ need: Need, toOrganizationWithKey organizationKey: String) {
        
    }
    
    func deleteNeedWithKey(_ needKey: String, toOrganizationWithKey organizationKey: String) {
        root.child(organizationKey).child(CHARITY_NEEDS_ROOT).child(needKey).setValue(nil)
    }
    
    func getNeedsFromOrganizationWithKey(_ organizationKey: String, to listener: IDatabaseResultListener) {
        let reference = Database.database().reference().root.child(organizationKey).child(CHARITY_NEEDS_ROOT)
        retrieveInfoItemsListFrom(reference, to: listener)
    }
    
    // MARK: - News
    
    func addNews(_ news: News, toOrganizationWithKey organizationKey: String) {
        let target = root.child(organizationKey).child(ORGANIZATION_NEWS_ROOT)
        addNews(news, to: target)
    }
    
    func addNews(_ news: News, toOrganizationWithKey organizationKey: String, toNeedWithKey needKey: String) {
        let target = root.child(organizationKey).child(CHARITY_NEEDS_ROOT).child(needKey).child(NEEDS_NEWS_ROOT)
        addNews(news, to: target)
    }
    
    func getNewsFromOrganizationWithKey(_ organizationKey: String, to listener: IDatabaseResultListener) {
        let reference = Database.database().reference().root.child(organizationKey).child(ORGANIZATION_NEWS_ROOT)
        retrieveInfoItemsListFrom(reference, to: listener)
    }
    
}
