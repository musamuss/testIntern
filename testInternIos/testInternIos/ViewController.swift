//
//  ViewController.swift
//  testInternIos
//
//  Created by Муса Дениев on 22.07.2019.
//  Copyright © 2019 musamuss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
      let structureMap   = loadJson(filename: "Structure")
        let draftValuesMap = loadJson(filename: "Draft_values")
        var structureJson = MassiveStructure(structureMap: structureMap!)
            let draftJson = MassiveDraft(draftValuesMap: draftValuesMap!)
            searchInMassive(structureArray: &structureJson, draftArray: draftJson)
            let endJson = MainStructure(params: structureJson)
            writeToJson(endJson: endJson, name: "Structure_with_values")
        } catch {
            ErrorFunc()
        }
    }
}
  //функции
func loadJson(filename fileName: String) -> [String:Any]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return jsonData as? [String:Any]
        } catch {
            print("error:\(error)")
        }
    }
    return nil
    }

func searchInMassive(structureArray: inout [Structure], draftArray: [Int: Draft]) {
    for i in 0..<structureArray.count {
        if draftArray[structureArray[i].id] != nil {
            if let buff = draftArray[structureArray[i].id]?.value as? Int {
                var (xString, yInt) : (String, Int) = ("", 0)
                for j in 0..<structureArray[i].values!.count {
                    if structureArray[i].values![j].id == buff {
                        xString = structureArray[i].values![j].title
                        yInt = j
                        break
                    }
                }
                structureArray[i].value = xString as String
                if structureArray[i].values![yInt].params != nil {
                    searchInMassive(structureArray: &structureArray[i].values![yInt].params!, draftArray: draftArray)
                }
            } else {
                structureArray[i].value = draftArray[structureArray[i].id]?.value as? String
            }
        }
    }
}

func MassiveDraft(draftValuesMap: [String:Any]) -> [Int : Draft]{
var draft: [Int : Draft] = [:]
    let DraftValuesMap = draftValuesMap["values"] as? [[String: Any]]
for json in DraftValuesMap! {
    if let newDraftValuesMap = Draft(json: json) {
        draft[newDraftValuesMap.id] = newDraftValuesMap
        }
    }
    return draft
}
func MassiveStructure(structureMap:[String:Any]) -> [Structure]{
    var structure : [Structure] = []
    let StructureMap = structureMap["params"] as? [[String: Any]]
    for json in StructureMap! {
        if let newStructureMap = Structure(json: json) {
            structure.append(newStructureMap)
        }
    }
    return structure
}

func writeToJson(endJson:MainStructure, name:String) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let data = try? encoder.encode(endJson)
    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let fileUrl = url!.appendingPathComponent(name)
    print("файл доступен по адресу   \(fileUrl)")
    do {
        try data!.write(to: fileUrl)
    } catch {
    }
    
}
func ErrorFunc() {
    let name = "error.json"
    let errorJSON = Error(error: Message(message: "Входные файлы являются некорректными"))
    let encoder = JSONEncoder()
    let data = try? encoder.encode(errorJSON)
    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let errorUrl = url!.appendingPathComponent(name)
    try? data?.write(to: errorUrl)
    print("файл доступен по адресу   \(errorUrl)")
}
