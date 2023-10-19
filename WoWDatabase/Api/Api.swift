//
//  Api.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 29.09.2023.
//

import Alamofire
import Combine

struct Api {
	static func send<T: RequestProtocol>(request: T) -> AnyPublisher<T.Response, AFError> {
		guard let url = URL(string: request.url) else {
			return Fail(error: AFError.invalidURL(url: request.url))
				.eraseToAnyPublisher()
		}
		let request = AF.request(url,
								 method: request.method,
								 parameters: request.parameters,
								 headers: request.headers)
		request.validate()
		request.responseData(completionHandler: { Api.log(result: $0) })
		return request
			.publishDecodable(type: T.Response.self)
			.value()
			.handleEvents(receiveCompletion: { result in
				if case let .failure(error) = result {
					print("❗️❗️❗️ AFError ❗️❗️❗️")
					print(error)
				}
			}).receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
	
	private static func log(result: AFDataResponse<Data>) {
		print("🚀🚀🚀 REQUEST 🚀🚀🚀")
		if let request = result.request {
			let method = request.method?.rawValue ?? ""
			let url = request.url?.absoluteString ?? ""
			print("\(method) \(url)")
			print(request.headers.description)
			if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
				print(bodyString)
			} else {
				print("Error load request body")
			}
		} else {
			print("Error load request")
		}
		print()
		print("🔈🔈🔈 RESPONSE 🔈🔈🔈")
		if let response = result.response {
			print("Status code: \(response.statusCode)")
		} else {
			print("Error load response code")
		}
		if let data = result.data, let dataString = String(data: data, encoding: .utf8) {
			print(dataString)
		} else {
			print("Error load response data")
		}
	}
}
