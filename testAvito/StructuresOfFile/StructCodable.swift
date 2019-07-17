//
//  StructCodable.swift
//  testAvito
//
//  Created by Admin on 17/07/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import Foundation
struct RequestCodable: Codable {
    var params:[Structure]?
}
struct Structure : Codable  {
    
    var id : Int
    var title : String
    var value: String?
    var values : [StructureValue]?
}
struct StructureValue : Codable {
    
    var id : Int
    var title : String
    var params : [Params]?
}

struct Params : Codable {
    
    var id : Int
    var title : String
    var value : String?
    var values : [ParamsValue]?
}

struct ParamsValue : Codable {
    
    var id : Int
    var title : String
}
