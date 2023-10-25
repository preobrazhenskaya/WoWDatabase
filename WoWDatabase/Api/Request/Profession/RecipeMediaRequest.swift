//
//  RecipeMediaRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 25.10.2023.
//

struct RecipeMediaRequest {
	let id: Int
}

extension RecipeMediaRequest: RequestProtocol {
	typealias Response = MediaModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.media)\(Constants.API.URL.recipe)/\(id)"
	}
}
