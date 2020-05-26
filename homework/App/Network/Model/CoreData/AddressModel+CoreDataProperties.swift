//
//  AddressModel+CoreDataProperties.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData


extension AddressModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddressModel> {
        return NSFetchRequest<AddressModel>(entityName: "AddressModel")
    }

    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var postalCode: String?
    @NSManaged public var state: String?
    @NSManaged public var street: String?
    @NSManaged public var ofLocation: LocationModel?

}
