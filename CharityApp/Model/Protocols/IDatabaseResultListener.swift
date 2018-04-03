//
//  IDatabaseListerner.swift
//  CharityApp
//
//  Created by Artur on 3/7/18.
//  Copyright © 2018 Artur. All rights reserved.
//

protocol IDatabaseResultListener {
    func onNewsListRetrieved(resultList: [String: News])
    func onNeedsListRetrieved(resultList: [String: Need])
    func onError()
}
