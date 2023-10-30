//
//  ItemMediaRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 25.10.2023.
//

struct ItemMediaRequest {
	let id: Int
}

extension ItemMediaRequest: RequestProtocol {
	typealias Response = MediaModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.media)\(Constants.API.URL.item)/\(id)"
	}
}
