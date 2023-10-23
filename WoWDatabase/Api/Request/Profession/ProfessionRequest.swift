//
//  ProfessionRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

struct ProfessionRequest {
	let id: Int
}

extension ProfessionRequest: RequestProtocol {
	typealias Response = ProfessionModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.profession)/\(id)"
	}
}
