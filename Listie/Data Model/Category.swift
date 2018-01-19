//
//  Category.swift
//  Listie
//
//  Created by Seth Chavis on 1/17/18.
//  Copyright © 2018 Joseth Chavis. All rights reserved.
//

import Foundation
import RealmSwift
class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
