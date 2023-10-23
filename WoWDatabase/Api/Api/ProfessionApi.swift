//
//  ProfessionApi.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import Alamofire
import Combine

struct ProfessionApi {
	static func getProfessionsList() -> AnyPublisher<ProfessionsListModel, AFError> {
		Api.send(request: ProfessionsListRequest())
	}
	
	static func getProfession(id: Int) -> AnyPublisher<ProfessionModel, AFError> {
		Api.send(request: ProfessionRequest(id: id))
	}
	
	static func getProfessionMedia(id: Int) -> AnyPublisher<MediaModel, AFError> {
		Api.send(request: ProfessionMediaRequest(id: id))
	}
	
	static func getSkillTier(professionId: Int, skillTierId: Int) -> AnyPublisher<SkillTierModel, AFError> {
		Api.send(request: SkillTierRequest(professionId: professionId, skillTierId: skillTierId))
	}
}
