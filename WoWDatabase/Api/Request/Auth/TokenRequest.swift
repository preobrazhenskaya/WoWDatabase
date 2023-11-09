//
//  TokenRequest.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 19.10.2023.
//

import Alamofire

struct TokenRequest: RequestProtocol {
	typealias Response = TokenModel
	let url = Constants.API.URL.auth
	let method = HTTPMethod.post
	
	let parameters = [
		Constants.API.Parameters.Keys.grantType: Constants.API.Parameters.Value.grantType,
		Constants.API.Parameters.Keys.clientId: ApiAuthService.getClientId(),
		Constants.API.Parameters.Keys.clientSecret: ApiAuthService.getClientSecret()
	]
	
	let headers: HTTPHeaders? = [
		Constants.API.Headers.Keys.contentType: Constants.API.Headers.Value.authContentType
	]
}
