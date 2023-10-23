//
//  ProfessionDetailVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import Combine
import Foundation

final class ProfessionDetailVM: BaseViewModel {
	@Published var profession: ProfessionModel?
	@Published var professionIcon: URL?
	
	private let professionId: Int
	private var professionLoading = CurrentValueSubject<Bool, Never>(false)
	var mediaLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(professionId: Int) {
		self.professionId = professionId
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		Publishers.CombineLatest(professionLoading, mediaLoading)
			.map { $0 || $1 }
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getProfession()
		getMedia()
	}
	
	private func getProfession() {
		ProfessionApi.getProfession(id: professionId)
			.trackLoading(professionLoading)
			.getError(errorText)
			.getResult()
			.assign(to: \.profession, on: self)
			.store(in: &cancellableSet)
	}
	
	private func getMedia() {
		ProfessionApi.getProfessionMedia(id: professionId)
			.trackLoading(mediaLoading)
			.getError(errorText)
			.getResult()
			.map { URL(string: $0?.assets?.first?.value ?? "") }
			.assign(to: \.professionIcon, on: self)
			.store(in: &cancellableSet)
	}
}
