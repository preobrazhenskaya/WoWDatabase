//
//  TitleRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 16.11.2023.
//

struct TitleRequest {
	let id: Int
}

extension TitleRequest: RequestProtocol {
	typealias Response = TitleModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.title)/\(id)"
	}
}
