//
//  MultilineText.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 30.10.2023.
//

import SwiftUI

struct MultilineText: View {
	let text: String
	let alignment: TextAlignment
	
    var body: some View {
        Text(text)
			.fixedSize(horizontal: false, vertical: true)
			.multilineTextAlignment(alignment)
    }
}

struct MultilineText_Previews: PreviewProvider {
    static var previews: some View {
		MultilineText(text: "Text", alignment: .center)
    }
}
