//
//  ViewController.swift
//  testAvito
//
//  Created by Admin on 17/07/2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import UIKit
public enum ParseError: Error {
    case badStructure
}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        let structureMap = loadJsonStructure(filename: "Structure")!
        let draftMap = loadJsonDraft(filename: "Draft_values")!
        
        for draft in draftMap {
            for var structure in structureMap where structure.id == draft.id {
                if ((draft.value as? String) != nil) {
                    structure.value = draft.value as? String
                } else {
                    structure.value = structure.values?.first(where: {$0.id == (draft.value as? Int) ?? nil})?.title
                    
                }
            dump(structure)
            }
        }
       
        
        
        
       // saveToJsonFile(json: structureMap, name: "Structure_with")
        
       
    }
        
    }
        
        

    
    
func saveToJsonFile(json : [Structure] , name : String) {
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func loadJsonStructure(filename fileName: String) -> [Structure]? {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(RequestCodable.self, from: data)
                    return jsonData.params
                } catch {
                    print("error:\(error)")
                }
            }
            return nil
        }
    
        func loadJsonDraft(filename fileName: String) -> [DraftValues]? {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(Draft.self, from: data)
                    return jsonData.values
                } catch {
                    print("error:\(error)")
                }
            }
            return nil
        }


