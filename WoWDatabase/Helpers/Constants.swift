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
			static let media = "/media"
			static let achievement = "/achievement"
			static let list = "/index"
		}
		
		enum Parameters {
			enum Keys {
				static let region = "region"
				static let namespace = "namespace"
				static let locale = "locale"
			}
			
			enum Value {
				static let regionEU = "eu"
				static let namespaceEU = "static-eu"
				static let localeRU = "ru_RU"
			}
		}
		
		enum Headers {
			enum Keys {
				static let authorization = "Authorization"
			}
			
			enum Value {
				static let bearer = "Bearer"
			}
		}
	}
}
