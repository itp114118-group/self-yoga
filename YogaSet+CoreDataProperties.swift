//
//  YogaSet+CoreDataProperties.swift
//  
//
//  Created by Jack on 24/12/2020.
//
//

import Foundation
import CoreData


extension YogaSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<YogaSet> {
        return NSFetchRequest<YogaSet>(entityName: "YogaSet")
    }

    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?

}
