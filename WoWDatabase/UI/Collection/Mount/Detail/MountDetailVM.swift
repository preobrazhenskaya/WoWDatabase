//
//  MountDetailVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 17.11.2023.
//

import Combine
import Alamofire

final class MountDetailVM: BaseViewModel {
	@Published var mount: MountModel?
	@Published var mountIcon: URL?
	@Published var inFav = false
	
	private let mountId: Int
	private let mountApi: MountApiProtocol
	private let dbService: DbService
	
	private var mountLoading = CurrentValueSubject<Bool, Never>(false)
	var iconLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(mountId: Int, mountApi: MountApiProtocol, dbService: DbService) {
		self.mountId = mountId
		self.mountApi = mountApi
		self.dbService = dbService
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		Publishers.CombineLatest(mountLoading, iconLoading)
			.map { $0 || $1 }
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getMount()
	}
	
	private func getMount() {
		let mountResponse = mountApi.getMount(id: mountId)
			.trackLoading(mountLoading)
			.getError(errorText)
			.getResult()
		
		mountResponse
			.assign(to: \.mount, on: self)
			.store(in: &cancellableSet)
		
		mountResponse
			.compactMap { $0?.creatureDisplays?.first?.key?.href }
			.flatMap { [weak self] url -> AnyPublisher<MediaModel, AFError> in
				guard let self = self else { return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher() }
				return self.mountApi.getMountImage(url: url)
			}
			.trackLoading(iconLoading)
			.getError(errorText)
			.getResult()
			.map { $0?.iconUrl }
			.assign(to: \.mountIcon, on: self)
			.store(in: &cancellableSet)
	}
	
	func checkInFav() {
		inFav = dbService.checkItemInFav(id: mountId, type: .mount)
	}
	
	func addInFavorites() {
		guard let mount = mount else {
			errorText.send(L10n.General.error)
			return
		}
		errorText.send(dbService.addInFavorites(id: mountId, name: mount.name, type: .mount))
		checkInFav()
	}
	
	func removeFromFavorites() {
		errorText.send(dbService.removeFromFavorites(id: mountId, type: .mount))
		checkInFav()
	}
}
