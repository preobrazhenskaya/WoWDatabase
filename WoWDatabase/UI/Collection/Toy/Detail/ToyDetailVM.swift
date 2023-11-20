//
//  ToyDetailVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 20.11.2023.
//

import Combine
import Foundation
import Alamofire

final class ToyDetailVM: BaseViewModel {
	@Published var toy: ToyModel?
	@Published var toyIcon: URL?
	@Published var inFav = false
	
	private let toyId: Int
	private let toyApi: ToyApiProtocol
	private let dbService: DbService
	
	private var toyLoading = CurrentValueSubject<Bool, Never>(false)
	var iconLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(toyId: Int, toyApi: ToyApiProtocol, dbService: DbService) {
		self.toyId = toyId
		self.toyApi = toyApi
		self.dbService = dbService
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		Publishers.CombineLatest(toyLoading, iconLoading)
			.map { $0 || $1 }
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getToy()
	}
	
	private func getToy() {
		let toyResponse = toyApi.getToy(id: toyId)
			.trackLoading(toyLoading)
			.getError(errorText)
			.getResult()
		
		toyResponse
			.assign(to: \.toy, on: self)
			.store(in: &cancellableSet)
		
		toyResponse
			.compactMap { $0?.media?.key?.href }
			.flatMap { [weak self] url -> AnyPublisher<MediaModel, AFError> in
				guard let self = self else { return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher() }
				return self.toyApi.getToyImage(url: url)
			}
			.trackLoading(iconLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.iconUrl }
			.assign(to: \.toyIcon, on: self)
			.store(in: &cancellableSet)
	}
	
	func checkInFav() {
		inFav = dbService.checkItemInFav(id: toyId, type: .toy)
	}
	
	func addInFavorites() {
		guard let toy = toy else {
			errorText.send(L10n.General.error)
			return
		}
		errorText.send(dbService.addInFavorites(id: toyId, name: toy.item?.name, type: .toy))
		checkInFav()
	}
	
	func removeFromFavorites() {
		errorText.send(dbService.removeFromFavorites(id: toyId, type: .toy))
		checkInFav()
	}
}
