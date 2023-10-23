//
//  ProfessionMediaRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

struct ProfessionMediaRequest {
	let id: Int
}

extension ProfessionMediaRequest: RequestProtocol {
	typealias Response = MediaModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.media)\(Constants.API.URL.profession)/\(id)"
	}
}
