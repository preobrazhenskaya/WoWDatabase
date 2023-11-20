//
//  PetAbilityRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

struct PetAbilityRequest {
	let id: Int
}

extension PetAbilityRequest: RequestProtocol {
	typealias Response = AbilityModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.petAbility)/\(id)"
	}
}
