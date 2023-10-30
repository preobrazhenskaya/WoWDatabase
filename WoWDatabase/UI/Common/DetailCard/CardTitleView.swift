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
		MultilineText(text: title ?? "", alignment: .center)
			.font(.customBoldLargeTitle)
    }
}

struct CardTitleView_Previews: PreviewProvider {
    static var previews: some View {
		CardTitleView(title: "Title")
    }
}
