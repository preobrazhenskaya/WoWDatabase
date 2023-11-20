//
//  MountListRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 17.11.2023.
//

struct MountListRequest: RequestProtocol {
	typealias Response = MountListModel
	let url = "\(Constants.API.URL.main)\(Constants.API.URL.mount)\(Constants.API.URL.list)"
}
