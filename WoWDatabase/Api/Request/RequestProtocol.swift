//
//  RequestProtocol.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

import Alamofire

protocol RequestProtocol {
	var endpoint: String { get }
	var method: HTTPMethod { get }
	var parameters: [String: String] { get }
	var headers: HTTPHeaders? { get }
	
	associatedtype Response: Decodable
}

extension RequestProtocol {
	static var defaultParameters: [String: String] {
		[
			Constants.API.Parameters.Keys.region: Constants.API.Parameters.Value.regionEU,
			Constants.API.Parameters.Keys.namespace: Constants.API.Parameters.Value.namespaceEU,
			Constants.API.Parameters.Keys.locale: Constants.API.Parameters.Value.localeRU
		]
	}
	
	static var defaultHeaders: HTTPHeaders? {
		[
			Constants.API.Headers.Keys.authorization: "\(Constants.API.Headers.Value.bearer) "
		]
	}
}
