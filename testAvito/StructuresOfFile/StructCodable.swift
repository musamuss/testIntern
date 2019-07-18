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
    init?(json: [String:Any]) {
      
        if let params = json["params"] as? [[String:Any]] {
            self.params = params.compactMap({valueJson ->
                Structure? in
                return Structure(json: valueJson)
            })
        }
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
    init?(json: [String:Any]) {
        guard let id = json["id"] as? Int,
        let title = json["title"] as? String,
        let value = json["value"] as? String? else { return nil}
    self.id = id
    self.title = title
    self.value = value
        if let values = json["values"] as? [[String:Any]] {
            self.values = values.compactMap({valueJson ->
                StructureValue? in
                return StructureValue(json: valueJson)
            })
        }
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
    init?(json: [String:Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String else { return nil}
        self.id = id
        self.title = title
        if let params = json["params"] as? [[String:Any]] {
            self.params = params.compactMap({valueJson ->
                Params? in
                return Params(json: valueJson)
            })
        }
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
    init?(json: [String:Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let value = json["value"] as? String? else { return nil}
        self.id = id
        self.title = title
        self.value = value
        if let values = json["values"] as? [[String:Any]] {
            self.values = values.compactMap({valueJson ->
                ParamsValue? in
                return ParamsValue(json: valueJson)
            })
        }
    }
    
    
    
    }

struct ParamsValue : Codable {
    
    var id : Int
    var title : String
    enum CodingKeys: String, CodingKey {
        case title
        case id
        }
    init?(json: [String:Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String else { return nil}
        self.id = id
        self.title = title
        }
    }

