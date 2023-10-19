//
//  BaseViewModel.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 17.10.2023.
//

import Combine

class BaseViewModel: ObservableObject {
	@Published var isLoading = true
	@Published var showError = false
	
	var cancellableSet: Set<AnyCancellable> = []
	var errorText = CurrentValueSubject<String, Never>("")
	
	init() {
		bind()
	}
	
	func bind() {
		$showError
			.removeDuplicates()
			.filter { !$0 }
			.map { _ in "" }
			.subscribe(errorText)
			.store(in: &cancellableSet)
		
		errorText
			.map { !$0.isEmpty }
			.assign(to: \.showError, on: self)
			.store(in: &cancellableSet)
	}
}
