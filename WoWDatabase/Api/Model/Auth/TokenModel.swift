//
//  TokenModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 29.09.2023.
//

struct TokenModel: Codable {
	let accessToken: String?
	let tokenType: String?
	let expiresIn: Int?
	let sub: String?
	
	private enum CodingKeys: String, CodingKey {
		case accessToken = "access_token"
		case tokenType = "token_type"
		case expiresIn = "expires_in"
		case sub
	}
}
