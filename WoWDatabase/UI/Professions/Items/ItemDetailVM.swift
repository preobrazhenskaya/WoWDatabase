//
//  ItemDetailVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 25.10.2023.
//

import Combine
import Foundation

final class ItemDetailVM: BaseViewModel {
	@Published var item: ItemModel?
	@Published var itemIcon: URL?
	
	private let id: Int
	private let professionApi: ProfessionApiProtocol
	private let itemLoading = CurrentValueSubject<Bool, Never>(false)
	let mediaLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(id: Int, professionApi: ProfessionApiProtocol) {
		self.id = id
		self.professionApi = professionApi
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		Publishers.CombineLatest(itemLoading, mediaLoading)
			.map { $0 || $1 }
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getItem()
		getMedia()
	}
	
	private func getItem() {
		professionApi.getItem(id: id)
			.trackLoading(itemLoading)
			.getError(errorText)
			.getResult()
			.assign(to: \.item, on: self)
			.store(in: &cancellableSet)
	}
	
	private func getMedia() {
		professionApi.getItemMedia(id: id)
			.trackLoading(mediaLoading)
			.getError(errorText)
			.getResult()
			.map { URL(string: $0?.assets?.first?.value ?? "") }
			.assign(to: \.itemIcon, on: self)
			.store(in: &cancellableSet)
	}
}
