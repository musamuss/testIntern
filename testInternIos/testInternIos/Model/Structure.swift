//
//  Structure.swift
//  testInternIos
//
//  Created by Муса Дениев on 22.07.2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import Foundation

struct MainStructure : Codable {
    var params : [Structure]
}

struct Structure : Codable {
    let id      : Int
    let title   : String
    var value   : String?
    var values  : [StructureValue]?
    
    init?(json: [String : Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let value = json["value"] as? String,
            let values = json["values"] as? [Any]?
            else {
                return nil
        }
        
        var valMass : [StructureValue]? = nil
        if values is [[String : Any]] && !values!.isEmpty {
            valMass = []
            for object in values! {
                if let obj = object as? [String: Any] {
                    valMass!.append(StructureValue(json: obj)!)
                }
            }
        }
        
        self.id = id
        self.title = title
        self.value = value
        self.values = valMass
    }
}

struct StructureValue : Codable {
    let id      : Int
    let title   : String
    var params  : [Structure]?
    
    init?(json: [String : Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let params = json["params"] as? [Any]?
            else {
                
                return nil
        }
        
        var paramMass : [Structure]? = nil
        if params is [[String : Any]] && !params!.isEmpty {
            paramMass = []
            for object in params! {
                if let obj = object as? [String: Any] {
                    paramMass!.append(Structure(json: obj)!)
                }
            }
        }
        self.id = id
        self.title = title
        self.params = paramMass
    }
}
