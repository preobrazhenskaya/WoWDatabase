//
//  CardTitleView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 27.10.2023.
//

import SwiftUI

struct CardTitleView: View {
	var title: String?
	
    var body: some View {
		Text(title ?? "")
			.font(.customBoldLargeTitle)
			.fixedSize(horizontal: false, vertical: true)
			.multilineTextAlignment(.center)
    }
}

struct CardTitleView_Previews: PreviewProvider {
    static var previews: some View {
		CardTitleView(title: "Title")
    }
}
