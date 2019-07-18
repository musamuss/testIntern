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
    enum CodingKeys: String, CodingKey {
        case params
        }
    }

struct Structure : Codable  {
    
    var id : Int
    var title : String 
    var value: String?
    var values : [StructureValue]?
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case value
        }
    
    }

struct StructureValue : Codable {
    
    var id : Int
    var title : String
    var params : [Params]?
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case params
        }
    }

struct Params : Codable {
    
    var id : Int
    var title : String
    var value : String?
    var values : [ParamsValue]?
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case value
        case values
        }
    }

struct ParamsValue : Codable {
    
    var id : Int
    var title : String
    enum CodingKeys: String, CodingKey {
        case title
        case id
        }
    }
