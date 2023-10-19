//
//  AuthApi.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 19.10.2023.
//

import Alamofire
import Combine

struct AuthApi {
	static func getToken() -> AnyPublisher<TokenModel, AFError> {
		Api.send(request: TokenRequest())
	}
}
