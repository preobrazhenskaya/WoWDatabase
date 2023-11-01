//
//  AuthVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 01.11.2023.
//

import Combine

final class AuthVM: BaseViewModel {
	@Published var login = ""
	@Published var password = ""
}
