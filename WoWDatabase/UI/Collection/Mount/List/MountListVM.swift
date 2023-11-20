//
//  MountListVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 17.11.2023.
//

import Combine

final class MountListVM: BaseViewModel {
	@Published var mounts = [NameIdModel]()
	
	private let mountApi: MountApiProtocol
	private var listLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(mountApi: MountApiProtocol) {
		self.mountApi = mountApi
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		listLoading
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getMounts()
	}
	
	private func getMounts() {
		mountApi.getMountList()
			.trackLoading(listLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.mounts ?? [] }
			.assign(to: \.mounts, on: self)
			.store(in: &cancellableSet)
	}
}
