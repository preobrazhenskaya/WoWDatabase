//
//  PetMediaRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

struct PetMediaRequest {
	let id: Int
}

extension PetMediaRequest: RequestProtocol {
	typealias Response = MediaModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.media)\(Constants.API.URL.pet)/\(id)"
	}
}
