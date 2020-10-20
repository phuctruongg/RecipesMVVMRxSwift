//
//  Articles.swift
//  News
//
//  Created by Apple on 9/24/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct Recipe : Decodable,Encodable {
    let id : String
    let name : String
    let description : String
    let thumnail : String
    init(recipesThumnail: String, recipesDescription: String, recipesTitle: String, id :String) {
        self.name = recipesTitle
        self.description = recipesDescription
        self.thumnail =  recipesThumnail
        self.id = id
    }
}

