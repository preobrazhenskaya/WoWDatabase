//
//  ProfessionsListRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

struct ProfessionsListRequest: RequestProtocol {
	typealias Response = ProfessionsListModel
	let url = "\(Constants.API.URL.main)\(Constants.API.URL.profession)\(Constants.API.URL.list)"
}
