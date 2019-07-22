//
//  Draft.swift
//  testInternIos
//
//  Created by Муса Дениев on 22.07.2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import Foundation
struct Draft {
    let id : Int
    let value: Any
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            json.keys.contains("value")
            else {
                return nil
        }
        let value = json["value"]
        self.id = id
        self.value = value!
    }
}
