//
//  ItemRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 25.10.2023.
//

struct ItemRequest {
	let id: Int
}

extension ItemRequest: RequestProtocol {
	typealias Response = ItemModel
	
	var url: String {
		"\(Constants.API.URL.main)\(Constants.API.URL.item)/\(id)"
	}
}
