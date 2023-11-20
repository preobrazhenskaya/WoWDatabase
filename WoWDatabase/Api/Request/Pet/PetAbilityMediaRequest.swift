//
//  PetAbilityMediaRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

struct PetAbilityMediaRequest {
	let id: Int
}

extension PetAbilityMediaRequest: RequestProtocol {
	typealias Response = MediaModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.media)\(Constants.API.URL.petAbility)/\(id)"
	}
}
