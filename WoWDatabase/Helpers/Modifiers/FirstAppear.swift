//
//  FirstAppear.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 13.10.2023.
//

import SwiftUI

public extension View {
	func onFirstAppear(_ action: @escaping () -> Void) -> some View {
		modifier(FirstAppear(action: action))
	}
}

private struct FirstAppear: ViewModifier {
	@State private var hasAppeared = false
	
	let action: () -> Void
	
	func body(content: Content) -> some View {
		content
			.onAppear {
				guard !hasAppeared else { return }
				hasAppeared = true
				action()
			}
	}
}
