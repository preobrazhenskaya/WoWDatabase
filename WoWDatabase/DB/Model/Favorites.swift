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
		case profession
		case recipe
	}
}

extension Favorites {
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
}
