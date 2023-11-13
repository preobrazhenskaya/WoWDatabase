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
	
	var users: [User] {
		get { Array((users_ as? Set<User>) ?? []) }
		set { users_ = Set(newValue) as NSSet }
	}
}
	
extension Favorites {
	static func getFavoritesRequest(predicate: NSPredicate) -> NSFetchRequest<Favorites> {
		let request = Favorites.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: "id_", ascending: true)]
		request.predicate = predicate
		return request
	}
	
	static func saveFav(achievement: AchievementModel, user: User, context: NSManagedObjectContext) -> String {
		guard let id = achievement.id else { return L10n.General.error }
		
		let predicate = NSPredicate(format: "id_ == %@ AND type_ == %@", "\(id)", TypeEnum.achievement.rawValue)
		let storedFav = try? context.fetch(Favorites.getFavoritesRequest(predicate: predicate)).first
		
		if let storedFav = storedFav {
			storedFav.users.append(user)
		} else {
			let fav = Favorites(context: context)
			fav.id = id
			fav.name = achievement.name
			fav.type = .achievement
			fav.users = [user]
		}
		
		return context.saveContext()
	}
	
	static func removeFav(id: Int, type: TypeEnum, user: User, context: NSManagedObjectContext) -> String {
		let predicate = NSPredicate(format: "id_ == %@ AND type_ == %@", "\(id)", type.rawValue)
		let fav = try? context.fetch(Favorites.getFavoritesRequest(predicate: predicate)).first
		guard let fav = fav else { return L10n.General.error }
		
		fav.users = fav.users.filter { $0 != user }
		if fav.users.isEmpty {
			context.delete(fav)
		}
		return context.saveContext()
	}
	
	static func checkInFav(id: Int, type: TypeEnum, user: User, context: NSManagedObjectContext) -> Bool {
		let predicate = NSPredicate(format: "id_ == %@ AND type_ == %@", "\(id)", type.rawValue)
		let achievement = try? context.fetch(Favorites.getFavoritesRequest(predicate: predicate)).first
		
		return achievement?.users.contains { $0 == user } ?? false
	}
}
