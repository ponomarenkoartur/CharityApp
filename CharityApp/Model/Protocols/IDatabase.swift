//
//  DatabaseProtocol.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

protocol IDatabase {
    
    // MARK: - Organization
    
    /**
     Add a new `Organization` object to the database.
     - parameters:
     - organization: Organization to add.
     */
    func addOrganization(_ organization: Organization)
    
    /**
     Method for deleting a certain `Organization`.
     - parameters:
     - organizationKey: Unique id key of the `Organization` to be deleted.
     */
    func deleteOrganization(withKey organizationKey: String)
    
    // MARK: - Needs
    
    /**
     Method for adding a new `Need` to a certain `Organization`.
     - parameters:
     - need: The `Need` which will be added to the `Organization` (found by the key).
     - organizationKey: The unique id key of `Organization` for the new `Need`.
     */
    func addNeed(_ need: Need, toOrganizationWithKey organizationKey: String)
    
    /**
     Method for updating the fields of `Need`.
     - parameters:
     - need: The `Need` object itself to be updated.
     - organizationKey: The unique id key of `Organization` for the new `Need`.
     - Note:
     That the unique id of the charityNeed should remain unmodified **
     */
    func updateNeed(_ need: Need, toOrganizationWithKey organizationKey: String)
    
    /**
     Method for deleting a certain `Need`.
     - parameters:
     - needKey: The unique id key of the `Need` to be deleted.
     - organizationKey: The unique id key of the `Organization` in which the `Need` to delete is located.
     */
    func deleteNeed(withKey needKey: String, toOrganizationWithKey organizationKey: String)
    
    /**
     Method for retrieving list of `Need` from database.
     - paramaters:
        - organizationKey: Unique id key of `Organization` from which to retrieve.
        - listener: The callback listener in which the result will come.
     */
    func getNeedsFromOrganization(withKey organizationKey: String, to listener: IDatabaseResultListener)
    
    // MARK: - News
    
    /**
     Method for adding a `News` (of global organization event) to a particular `Organization`.
     - parameters:
        - news: The `News` object itself to be placed in the needed `Organization`.
        - organizationKey: Unique id key of `Organization` where the `News` should be placed.
     */
    func addNews(_ news: News, toOrganizationWithKey organizationKey: String)
    
    /**
     Method for adding a `News` (of event in a particular `Need`) in a particular `Organization`.
     - parameters:
     - news: The `News` object itself to be placed in the needed `Need`.
     - organizationKey: Unique id key of the `Organization` in which the given `Need` (found by the charityNeedKey) is located.
     - charityNeedKey  - Unique id key of the `Need` in which the `News` object should be placed.
     */
    func addNews(_ news: News, toOrganizationWithKey organizationKey: String, toNeedWithKey needKey: String)
    
    /**
     Method for retrieving `CharityOrganization` `CharityNews` from database.
     
     - parameters:
        - organizationKey: Unique id key of `Organization`  from which to get the `News`.
        - listener: The callback listener in which the result will come.
     */
    func getNewsFromOrganizationWithKey(_ organizationKey: String, to listener: IDatabaseResultListener);
}
