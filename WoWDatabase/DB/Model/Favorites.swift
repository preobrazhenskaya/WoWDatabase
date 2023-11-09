//
//  Favorites+CoreData.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 08.11.2023.
//

import CoreData

extension Favorites {
	enum TypeEnum: String {
		case none
		case achievement
	}
	
	public var id: Int {
		get { Int(id_) }
		set { id_ = Int64(newValue) }
	}
	
	var type: TypeEnum {
		get { TypeEnum(rawValue: type_ ?? "") ?? .none }
		set { type_ = newValue.rawValue }
	}
}
	
extension Favorites {
	static func getFavoritesRequest(predicate: NSPredicate) -> NSFetchRequest<Favorites> {
		let request = Favorites.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: "id_", ascending: true)]
		request.predicate = predicate
		return request
	}
	
	static func saveFav(achievement: AchievementModel, context: NSManagedObjectContext) -> String {
		let authService = AuthService(context: context)
		guard let id = achievement.id, let user = authService.getActiveUser() else { return L10n.General.error }
		let fav = Favorites(context: context)
		fav.id = id
		fav.name = achievement.name
		fav.type = .achievement
		fav.userId = NSSet(array: [user])
		return context.saveContext()
	}
	
	static func removeFav(id: Int, type: TypeEnum, context: NSManagedObjectContext) -> String {
		let predicate = NSPredicate(format: "id_ == %@ AND type_ == %@", "\(id)", type.rawValue)
		let fav = try? context.fetch(Favorites.getFavoritesRequest(predicate: predicate)).first
		guard let fav = fav else { return L10n.General.error }
		context.delete(fav)
		return context.saveContext()
	}
	
	static func checkInFav(id: Int, type: TypeEnum, context: NSManagedObjectContext) -> Bool {
		let predicate = NSPredicate(format: "id_ == %@ AND type_ == %@", "\(id)", type.rawValue)
		let achievement = try? context.fetch(Favorites.getFavoritesRequest(predicate: predicate)).first
		return !(achievement == nil)
	}
}
