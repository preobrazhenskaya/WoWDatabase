//
//  DisplayStringModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 30.10.2023.
//

struct DisplayStringModel: Codable {
	let displayString: String?
	
	private enum CodingKeys: String, CodingKey {
		case displayString = "display_string"
	}
}

struct DisplayModel: Codable, Identifiable {
	var id: String {
		display?.displayString ?? ""
	}
	
	let display: DisplayStringModel?
}
