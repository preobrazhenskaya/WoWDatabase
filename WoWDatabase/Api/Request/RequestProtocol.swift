//
//  RequestProtocol.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

import Alamofire

protocol RequestProtocol {
	associatedtype Response: Decodable
	
	var url: String { get }
	var method: HTTPMethod { get }
	var parameters: [String: String] { get }
	var headers: HTTPHeaders? { get }
}

extension RequestProtocol {
	var method: HTTPMethod {
		.get
	}
	
	var parameters: [String: String] {
		[
			Constants.API.Parameters.Keys.region: Constants.API.Parameters.Value.regionEU,
			Constants.API.Parameters.Keys.namespace: Constants.API.Parameters.Value.namespaceEU,
			Constants.API.Parameters.Keys.locale: Constants.API.Parameters.Value.localeRU
		]
	}
	
	var headers: HTTPHeaders? {
		[
			Constants.API.Headers.Keys.authorization: "\(Constants.API.Headers.Value.bearer) \(ApiAuthService.getToken() ?? "")"
		]
	}
}
