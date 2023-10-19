//
//  Publisher+Extension.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 17.10.2023.
//

import Combine
import Alamofire

extension Publisher {
	func getResult() -> AnyPublisher<Output?, Never>
	where Output: Codable {
		map { $0 }
			.replaceError(with: nil)
			.eraseToAnyPublisher()
	}
	
	func trackLoading(_ isLoading: PassthroughSubject<Bool, Never>) -> AnyPublisher<Output, Failure> {
		handleEvents(receiveSubscription: { _ in
			isLoading.send(true)
		}, receiveOutput: { _ in
			isLoading.send(false)
		}, receiveCompletion: { _ in
			isLoading.send(false)
		})
		.eraseToAnyPublisher()
	}
	
	func getError(_ errorMessage: CurrentValueSubject<String, Never>) -> AnyPublisher<Output, Failure>
	where Failure == AFError {
		handleEvents(receiveCompletion: { result in
			if case let .failure(error) = result {
				errorMessage.send(error.localizedDescription)
			}
		}).eraseToAnyPublisher()
	}
}
