//
//  Constants.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 12.10.2023.
//

enum Constants {
	enum API {
		enum URL {
			static let main = "https://eu.api.blizzard.com/data/wow"
			static let auth = "https://oauth.battle.net/token"
			
			static let media = "/media"
			static let list = "/index"
			
			static let profession = "/profession"
			static let skillTier = "/skill-tier"
			static let recipe = "/recipe"
			static let item = "/item"
			static let achievement = "/achievement"
			static let title = "/title"
			static let mount = "/mount"
			static let pet = "/pet"
			static let petAbility = "/pet-ability"
			static let toy = "/toy"
		}
		
		enum Parameters {
			enum Keys {
				static let region = "region"
				static let namespace = "namespace"
				static let locale = "locale"
				static let grantType = "grant_type"
				static let clientId = "client_id"
				static let clientSecret = "client_secret"
			}
			
			enum Value {
				static let regionEU = "eu"
				static let namespaceEU = "static-eu"
				static let localeRU = "ru_RU"
				static let grantType = "client_credentials"
			}
		}
		
		enum Headers {
			enum Keys {
				static let authorization = "Authorization"
				static let contentType = "Content-Type"
			}
			
			enum Value {
				static let bearer = "Bearer"
				static let authContentType = "application/x-www-form-urlencoded"
			}
		}
	}
	
	enum Services {
		enum Auth {
			static let token = "Token"
			static let clientId = "WOW_API_CLIENT_ID"
			static let clientSecret = "WOW_API_CLIENT_SECRET"
		}
	}
	
	enum DB {
		static let name = "WoWDatabase"
	}
}
