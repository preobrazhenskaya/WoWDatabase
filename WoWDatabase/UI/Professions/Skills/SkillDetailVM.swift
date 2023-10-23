//
//  SkillDetailVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 23.10.2023.
//

import Combine

final class SkillDetailVM: BaseViewModel {
	@Published var skill: SkillTierModel?
	
	private let skillId: Int
	private let professionId: Int
	private var skillLoading = CurrentValueSubject<Bool, Never>(false)
	
	init(skillId: Int, professionId: Int) {
		self.skillId = skillId
		self.professionId = professionId
		super.init()
	}
	
	override func bind() {
		super.bind()
		
		skillLoading
			.assign(to: \.isLoading, on: self)
			.store(in: &cancellableSet)
	}
	
	func loadData() {
		getSkill()
	}
	
	private func getSkill() {
		ProfessionApi.getSkillTier(professionId: professionId, skillTierId: skillId)
			.trackLoading(skillLoading)
			.getError(errorText)
			.getResult()
			.assign(to: \.skill, on: self)
			.store(in: &cancellableSet)
	}
}
