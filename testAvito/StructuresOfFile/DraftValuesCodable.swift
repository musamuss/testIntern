//
//  DraftValuesCodable.swift
//  testAvito
//
//  Created by Admin on 17/07/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import Foundation

struct Draft  {
    var values : [DraftValues]?
    enum CodingKeys: String, CodingKey {
        case values
    }
    init?(json: [String:Any]) {
        if let values = json["values"] as? [[String:Any]] {
            self.values = values.compactMap({valueJson ->
                DraftValues? in
                return DraftValues(json: valueJson)
            })
        }
    }
    }

struct DraftValues {
    let id : Int
    let value: Any
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            json.keys.contains("value")
            else {
                return nil
        }
        let value = json["value"]
        (self.id, self.value) = (id, value!)
    }
}
    
    
    
            
    

//extension DraftValues {
//        init(from decoder: Decoder) throws {
//
//            do {
//                let container = try decoder.container(keyedBy: CodingKeys.self)
//                if let stringProperty = try? container.decode(String.self, forKey: .value) {
//                    value = stringProperty
//                    //id = try! container.decode(Int.self, forKey: .id)
//                } else if let intProperty = try? container.decode(Int.self, forKey: .value) {
//                    value = intProperty
//                    //id = try! container.decode(Int.self, forKey: .id)
//                } else {
//                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath, debugDescription: "Not a JSON"))
//                }
//
//            }
//
//        }
//}


