//
//  SkillTierRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

struct SkillTierRequest {
	let professionId: Int
	let skillTierId: Int
}

extension SkillTierRequest: RequestProtocol {
	typealias Response = SkillTierModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.profession)/\(professionId)\(Constants.API.URL.skillTier)/\(skillTierId)"
	}
}
