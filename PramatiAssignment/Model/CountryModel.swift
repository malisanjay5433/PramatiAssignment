//
//  CountryModel.swift
//  PramatiAssignment
//
//  Created by Sanjay Mali on 06/12/17.
//  Copyright © 2017 Sanjay Mali. All rights reserved.
//

import Foundation
struct CountryModel {
    var name:String?
    var population:String? = "0"
    init(name:String,population:String) {
        self.name = name
        self.population = population
    }
}


