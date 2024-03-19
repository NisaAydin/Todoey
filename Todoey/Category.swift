//
//  Category.swift
//  Todoey
//
//  Created by Nisa Aydin on 22.02.2024.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
