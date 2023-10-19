//
//  TabsView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.10.2023.
//

import SwiftUI

struct TabsView: View {
	var body: some View {
		TabView {
			ForEach(TabEnum.allCases) { tab in
				tab.contentView
					.tabItem { Label(tab.title, systemSymbol: tab.icon) }
					.tag(tab)
			}
			.setTabBarTheme()
		}
		.setTabItemTheme()
	}
}

struct TabsView_Previews: PreviewProvider {
	static var previews: some View {
		TabsView()
	}
}
