//
//  CollectionVM.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 15.11.2023.
//

import Combine
import SwiftUI

final class CollectionVM: BaseViewModel {
	let rows: [(String, Image, Router.Destination)] = [
		(L10n.Achievements.title, Image(systemSymbol: .trophyFill), .achievementsList)
	]
}
