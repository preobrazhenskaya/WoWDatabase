//
//  RecipeRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 25.10.2023.
//

struct RecipeRequest {
	let id: Int
}

extension RecipeRequest: RequestProtocol {
	typealias Response = RecipeModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.recipe)/\(id)"
	}
}
