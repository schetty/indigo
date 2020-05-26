//
//  ResponseModel+CoreDataProperties.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData


extension ResponseModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResponseModel> {
        return NSFetchRequest<ResponseModel>(entityName: "ResponseModel")
    }

    @NSManaged public var data: DataModel?

}
