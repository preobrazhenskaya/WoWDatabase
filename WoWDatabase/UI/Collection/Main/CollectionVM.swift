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
		(L10n.Achievements.title, Image(systemSymbol: .trophyFill), .achievementsList),
		(L10n.Title.title, Image(systemSymbol: .medalFill), .titleList),
		(L10n.Mount.title, Image(systemSymbol: .hareFill), .mountList),
		(L10n.Pet.title, Image(systemSymbol: .pawprintFill), .petList),
		(L10n.Toy.title, Image(systemSymbol: .teddybearFill), .toyList)
	]
}
