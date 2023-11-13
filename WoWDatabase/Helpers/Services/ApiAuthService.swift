//
//  ApiAuthService.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 19.10.2023.
//

import Foundation

struct ApiAuthService {
	static func getClientId() -> String {
		Bundle.main.object(forInfoDictionaryKey: Constants.Services.Auth.clientId) as? String ?? ""
	}
	
	static func getClientSecret() -> String {
		Bundle.main.object(forInfoDictionaryKey: Constants.Services.Auth.clientSecret) as? String ?? ""
	}
	
	static func saveToken(_ token: String?) {
		UserDefaults.standard.setValue(token, forKey: Constants.Services.Auth.token)
	}
	
	static func getToken() -> String? {
		UserDefaults.standard.string(forKey: Constants.Services.Auth.token)
	}
}
