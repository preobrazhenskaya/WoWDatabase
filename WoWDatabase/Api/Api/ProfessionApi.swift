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
}
