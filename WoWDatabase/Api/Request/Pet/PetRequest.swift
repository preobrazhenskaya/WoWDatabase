//
//  PetRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

struct PetRequest {
	let id: Int
}

extension PetRequest: RequestProtocol {
	typealias Response = PetModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.pet)/\(id)"
	}
}
