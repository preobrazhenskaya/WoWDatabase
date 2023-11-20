//
//  MountRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 17.11.2023.
//

struct MountRequest {
	let id: Int
}

extension MountRequest: RequestProtocol {
	typealias Response = MountModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.mount)/\(id)"
	}
}
