//
//  BoldColonTextView.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 27.10.2023.
//

import SwiftUI

struct BoldColonTextView: View {
	var boldText: String
	
    var body: some View {
		MultilineText(text: "\(boldText):", alignment: .leading)
			.bold()
    }
}

struct BoldColonTextView_Previews: PreviewProvider {
    static var previews: some View {
		BoldColonTextView(boldText: "BoldText")
    }
}
