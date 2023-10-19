//
//  ThemeService.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 10.10.2023.
//

import SwiftUI

public extension View {
	func setTabBarTheme() -> some View {
		modifier(TabBarTheme())
	}
	
	func setTabItemTheme() -> some View {
		modifier(TabItemTheme())
	}
	
	func setNavigationBar(title: String, dismiss: DismissAction?, showBack: Bool) -> some View {
		modifier(NavigationBarTheme(title: title, dismiss: dismiss, showBack: showBack))
	}
	
	func setBackgroundTheme() -> some View {
		modifier(ViewBackgroundTheme())
	}
	
	func withLoader(isLoading: Bool) -> some View {
		modifier(CustomMainProgressView(isLoading: isLoading))
	}
	
	func withErrorAlert(isPresented: Binding<Bool>, errorText: String) -> some View {
		modifier(ErrorAlert(isPresented: isPresented, errorText: errorText))
	}
}

// MARK: - TabBar
struct TabBarTheme: ViewModifier {
	func body(content: Content) -> some View {
		content
			.toolbarBackground(Color.navigation, for: .tabBar)
			.toolbarBackground(.visible, for: .tabBar)
	}
}

struct TabItemTheme: ViewModifier {
	func body(content: Content) -> some View {
		content
			.tint(.textMain)
	}
}

// MARK: - NavigationBar
struct NavigationBarTheme: ViewModifier {
	let title: String
	let dismiss: DismissAction?
	let showBack: Bool
	
	func body(content: Content) -> some View {
		content
			.navigationBarBackButtonHidden(true)
			.toolbar {
				if let dismiss = dismiss, showBack {
					ToolbarItem(placement: .navigationBarLeading) {
						Button(action: {
							dismiss()
						}, label: {
							Image(systemSymbol: .chevronBackward)
						})
					}
				}
				ToolbarItem(placement: .principal) {
					Text(title)
						.foregroundColor(.textMain)
						.bold()
				}
			}
			.navigationBarTitleDisplayMode(.inline)
			.toolbarBackground(Color.navigation, for: .navigationBar)
	}
}

// MARK: - View
struct ViewBackgroundTheme: ViewModifier {
	func body(content: Content) -> some View {
		content
			.scrollContentBackground(.hidden)
			.background(
				ZStack {
					RadialGradient(
						colors: [Color.backgroundGradientAccent,
								 Color.background],
						center: .topTrailing,
						startRadius: 0,
						endRadius: 350)
					RadialGradient(
						colors: [Color.backgroundGradientAccent,
								 Color.clear],
						center: .bottomLeading,
						startRadius: 0,
						endRadius: 350)
				}.ignoresSafeArea()
			)
	}
}

// MARK: - ProgressView
struct CustomProgressView: View {
	var isLoading: Bool
	
	var body: some View {
		ProgressView()
			.scaleEffect(5, anchor: .center)
			.progressViewStyle(.circular)
			.opacity(isLoading ? 1 : 0)
	}
}

struct CustomMainProgressView: AnimatableModifier {
	var isLoading: Bool
	
	func body(content: Content) -> some View {
		if isLoading {
			ZStack(alignment: .center) {
				content
					.disabled(isLoading)
					.blur(radius: isLoading ? 5 : 0)
				CustomProgressView(isLoading: isLoading)
			}
		} else {
			content
		}
	}
}

// MARK: - ErrorAlert
struct ErrorAlert: ViewModifier {
	var isPresented: Binding<Bool>
	var errorText: String
	
	func body(content: Content) -> some View {
		content
			.alert(L10n.General.error, isPresented: isPresented, actions: {
				Button(L10n.General.ok) { }
			}, message: {
				Text(errorText)
			})
	}
}
