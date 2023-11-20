//
//  ToyRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

struct ToyRequest {
	let id: Int
}

extension ToyRequest: RequestProtocol {
	typealias Response = ToyModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.toy)/\(id)"
	}
}
