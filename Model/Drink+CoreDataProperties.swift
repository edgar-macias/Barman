//
//  Drink+CoreDataProperties.swift
//  Barman
//
//  Created by Edgar Macias on 28/02/23.
//
//

import Foundation
import CoreData


extension Drink {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Drink> {
        return NSFetchRequest<Drink>(entityName: "Drink")
    }

    @NSManaged public var img: String?
    @NSManaged public var indications: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var name: String?

}

extension Drink : Identifiable {

}
