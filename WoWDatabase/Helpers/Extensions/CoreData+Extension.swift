//
//  CoreData+Extension.swift
//  WoWDatabase
//
//  Created by Яна Преображенская on 01.11.2023.
//

import CoreData

extension NSManagedObjectContext {
	func saveContext() -> String {
		do {
			try self.save()
			return ""
		} catch {
			let nsError = error as NSError
			return "Unresolved error \(nsError), \(nsError.userInfo)"
		}
	}
}
