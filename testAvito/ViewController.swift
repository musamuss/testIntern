//
//  ViewController.swift
//  testAvito
//
//  Created by Admin on 17/07/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
//      let structureMap = loadJson(filename: "Structure")
////
//  dump(structureMap)
       let draftMap = loadJson(filename: "Draft_values")!
        saveToJsonFile(json: draftMap, name: "filename")
        //print(draftMap)
//        for draft in draftMap {
//            for var structure in structureMap! where structure.id == draft.id {
//                if ((draft.value as? String) != nil) {
//                    structure.value = draft.value as? String
//                } else {
//                    structure.value = structure.values?.first(where: {$0.id == (draft.value as? Int) ?? nil})?.title
//
//
//                }
//
//           dump(structure)
//            }
//        }
     //  let url = Bundle.main.url(forResource: "Structure", withExtension: "json")
       // let data = try? Data(contentsOf: url!)
//        let decoder = JSONDecoder()
//        let jsonData = try? decoder.decode(RequestCodable.self, from: data!)
//        dump(jsonData)
//           }
//
        
        
    }
    
    
}

func saveToJsonFile(json : [String:Any] , name : String) {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent(name)
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            print(fileUrl)
            try data.write(to: fileUrl, options: [])
        } catch {
            print(error)
        }
    }

func loadJson(filename fileName: String) -> [String:Any]? {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    return jsonData as? [String:Any]
                } catch {
                    print("error:\(error)")
                }
            }
            return nil
        }



