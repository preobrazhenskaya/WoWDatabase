//
//  MountImageRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

struct MountImageRequest {
	let imageUrl: String
}

extension MountImageRequest: RequestProtocol {
	typealias Response = MediaModel
	
	var url: String {
		imageUrl
	}
}
