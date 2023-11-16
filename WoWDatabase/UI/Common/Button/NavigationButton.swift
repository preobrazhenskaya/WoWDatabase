//
//  NavigationButton.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 31.10.2023.
//

import SwiftUI

struct NavigationButton: View {
	let destination: Router.Destination
	let label: String
	
	var body: some View {
		NavigationLink(
			destination: {
				Router.navigate(to: destination)
			},
			label: {
				ZStack {
					Color.accentColor
					Text(label)
						.foregroundColor(.white)
				}
				.frame(height: 52)
				.cornerRadius(10)
			}
		)
	}
}

struct NavigationButton_Previews: PreviewProvider {
    static var previews: some View {
		NavigationButton(destination: .registration, label: "Navigation Button")
    }
}
