//
//  ActionButton.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 31.10.2023.
//

import SwiftUI

struct ActionButton: View {
	let action: () -> Void
	let label: String
	
    var body: some View {
		Button(
			action: action,
			label: {
				ZStack {
					Color.backgroundDark
					Text(label)
						.foregroundColor(.white)
				}
			}
		)
		.frame(height: 52)
		.cornerRadius(10)
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
		ActionButton(action: {}, label: "Button")
    }
}
