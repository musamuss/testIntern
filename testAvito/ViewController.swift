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
     
        let structureJSON = loadJson(filename: "Structure")
        let draftJSON = loadJson(filename: "Draft_values")
        let structureMap = RequestCodable(json: structureJSON!)
        let draftMap = Draft(json: draftJSON!)
        //dump(structureMap)
        
     //   saveToJsonFile(json: structureJSON!, name: "/name.json")


    }
   
    
}



// functions


//сохранение в файл

func saveToJsonFile(json : [String:Any] , name : String) {
    let file = "name.json"
    let path = URL(fileURLWithPath: "/Users⁩/⁨admin⁩/Documents⁩/GitHub⁩/testAvito⁩/testIntern⁩/testAvito⁩")
    if let dir =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        do {
            let fileURL = dir.appendingPathComponent(file)
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            print(fileURL)
            try data.write(to: fileURL)
        } catch {
            print(error)
        }
    }
}

 // загрузка файлов
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


func search(structure: inout [Structure], draft: [DraftValues]) {
    for i in 0...structure.count-1 {
        if draft[structure[i].id] != nil {
            if let newKey = draft[structure[i].id].value as? Int{
                var (newValue, index) = ("",0)
                for j in 0...structure[i].values!.count-1{
                    if structure[i].values![j].id == newKey {
                        newValue = structure[i].values![j].title
                        index = j
                        break
                    }
                    if j == structure[i].values!.count {
                        print("Error")
                    }
                }
               structure[i].value = newValue as String
                if structure[i].values![index].params != nil {
                    search(structure: &structure[i].values![index].params!, draft: draft)
                }
            } else {
                structure[i].value = draft[structure[i].id].value as? String
            }
        }
    }
}
