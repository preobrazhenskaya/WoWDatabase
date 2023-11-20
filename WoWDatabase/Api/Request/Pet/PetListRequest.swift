//
//  PetListRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

struct PetListRequest: RequestProtocol {
	typealias Response = PetListModel
	let url = "\(Constants.API.URL.main)\(Constants.API.URL.pet)\(Constants.API.URL.list)"
}
