//
//  User+CoreData.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 03.11.2023.
//

import CoreData

extension User {
	static func findUserRequest(predicate: NSPredicate) -> NSFetchRequest<User> {
		let request = User.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: "login", ascending: true)]
		request.predicate = predicate
		return request
	}
}
