//
//  BoldColonRegularTextView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 27.10.2023.
//

import SwiftUI

struct BoldColonRegularTextView: View {
	var boldText: String
	let regularText: String?
	
    var body: some View {
		HStack(alignment: .top) {
			BoldColonTextView(boldText: boldText)
			MultilineText(text: regularText ?? "-", alignment: .leading)
		}
    }
}

struct BoldColonRegularTextView_Previews: PreviewProvider {
    static var previews: some View {
		BoldColonRegularTextView(boldText: "BoldText", regularText: "RegularText")
    }
}
