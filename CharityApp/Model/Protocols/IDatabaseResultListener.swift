//
//  IDatabaseListerner.swift
//  CharityApp
//
//  Created by Artur on 3/7/18.
//  Copyright © 2018 Artur. All rights reserved.
//

protocol IDatabaseResultListener {
    func onInfoItemsListRetrieved(resultList: [InfoItem])
    func onError()
}
