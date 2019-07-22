//
//  error.swift
//  testInternIos
//
//  Created by Муса Дениев on 22.07.2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import Foundation
struct Error : Codable {
    let error : Message
}

struct Message : Codable {
    let message : String
}
