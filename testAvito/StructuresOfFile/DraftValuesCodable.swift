//
//  DraftValuesCodable.swift
//  testAvito
//
//  Created by Admin on 17/07/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import Foundation

struct Draft : Decodable {
    var values : [DraftValues]?
    }

struct DraftValues: Decodable {
    var id: Int
    var value: Any
    
    enum CodingKeys: String, CodingKey {
        case value
        case id
    }
  
    init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let stringProperty = try? container.decode(String.self, forKey: .value) {
                value = stringProperty
                id = try! container.decode(Int.self, forKey: .id)
            } else if let intProperty = try? container.decode(Int.self, forKey: .value) {
                value = intProperty
                id = try! container.decode(Int.self, forKey: .id)
            } else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath, debugDescription: "Not a JSON"))
            }
            
        }
        
    }
    
}
    

