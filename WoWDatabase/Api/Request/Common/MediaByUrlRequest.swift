//
//  MediaByUrlRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

struct MediaByUrlRequest {
	let imageUrl: String
}

extension MediaByUrlRequest: RequestProtocol {
	typealias Response = MediaModel
	
	var url: String {
		imageUrl
	}
}
