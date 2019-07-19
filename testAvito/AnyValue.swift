//
//  AnyValue.swift
//  testAvito
//
//  Created by Admin on 19/07/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import Foundation
struct AnyValue: Codable {
    
    private var int: Int?
    private var string: String?
    
    init(_ int: Int) {
        self.int = int
    }
    
    init(_ string: String) {
        self.string = string
    }
    
    
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self.int = int
            return
        }
        
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self.string = string
            return
        }
        
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        if let anyValue = self.value() {
            if let value = anyValue as? Int {
                try container.encode(value)
                return
            }
            
            if let value = anyValue as? String {
                try container.encode(value)
                return
            }
            
        }
        
        try container.encodeNil()
    }
    
    
    func value() -> Any? {
        return self.int ?? self.string
    }
}
