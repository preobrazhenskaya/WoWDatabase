//
//  User+CoreData.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.11.2023.
//

import CoreData

extension User {
	var favorites: [Favorites] {
		get { Array((favorites_ as? Set<Favorites>) ?? []) }
		set { favorites_ = Set(newValue) as NSSet }
	}
}

extension User {
	static func getUsersRequest(predicate: NSPredicate) -> NSFetchRequest<User> {
		let request = User.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: "login", ascending: true)]
		request.predicate = predicate
		return request
	}
}
