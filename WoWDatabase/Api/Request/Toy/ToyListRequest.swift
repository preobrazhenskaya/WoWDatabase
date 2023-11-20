//
//  ToyListRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

struct ToyListRequest: RequestProtocol {
	typealias Response = ToyListModel
	let url = "\(Constants.API.URL.main)\(Constants.API.URL.toy)\(Constants.API.URL.list)"
}
