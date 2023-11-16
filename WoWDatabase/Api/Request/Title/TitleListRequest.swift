//
//  TitleListRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 16.11.2023.
//

struct TitleListRequest: RequestProtocol {
	typealias Response = TitleListModel
	let url = "\(Constants.API.URL.main)\(Constants.API.URL.title)\(Constants.API.URL.list)"
}
