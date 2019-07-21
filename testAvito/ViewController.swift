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
        var structureMap = RequestCodable(json: structureJSON!)
        let draftMap = Draft(json: draftJSON!)
        //dump(structureMap)
       search(structure: &structureMap!, draft: draftMap!)
        //dump(result)
        let dic: [String:Any] = structureMap
        let data = try? JSONEncoder().encode(structureMap) as? [String:Any]
        
        
       
        saveToJSON(json: data!, name: "kek.json")

    }
   
    
}



// functions


//сохранение в файл
func saveToJSON (json: [String:Any], name: String){
    guard let URLdir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        return
    }
    let fileUrl = URLdir.appendingPathComponent(name)
    do {
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        print(fileUrl)
        try data.write(to: fileUrl)
    } catch {
        print(error)
    }
    }


//func saveTo(result: StructureWithValues, path: String) {
//    let encoder = JSONEncoder()
//    encoder.outputFormatting = .prettyPrinted
//    let data = try? encoder.encode(result)
//    do {
//        try data!.write(to: URL(fileURLWithPath: path + "result.json"))
//    } catch {
//        print("error 04: incorrect URL")
//    }
//
//}

//func saveToJsonFile(json : StructureWithValues) {
//    let file = "/name.json"
//    //let path = URL(fileURLWithPath: "/Users⁩/⁨admin⁩/Documents⁩/GitHub⁩/testAvito⁩/testIntern⁩/testAvito⁩")
//    if let dir =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//        do {
//            let fileURL = dir.appendingPathComponent(file)
//            let data = try JSONSerialization.data(withJSONObject: json, options: [])
//            print(fileURL)
//            try data.write(to: fileURL)
//        } catch {
//            print(error)
//        }
//    }
//}

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


func search(structure: inout RequestCodable, draft: Draft) {
    var i = 0
    for selectedStructure in structure.params!{
        for draftSelected in draft.values!{
            if selectedStructure.id == draftSelected.id{
                if selectedStructure.values != nil{
                    for selectedStructureValues in selectedStructure.values!{
                        if selectedStructureValues.id == draftSelected.value as? Int{
                            if selectedStructureValues.params != nil{
                                structure.params![i].value = "\(selectedStructureValues.title)  \(subSearch(structure: selectedStructureValues, draft: draft))"
                            }
                            else{
                                structure.params![i].value = selectedStructureValues.title
                            }
                        }
                    }
                }
                else{
                    structure.params![i].value = draftSelected.value as? String
                }
            }
        }
        i+=1
    }
}
func subSearch(structure:  StructureValue, draft: Draft) -> String {
    
    for selectedStructure in structure.params!{
        for draftSelected in draft.values!{
            if selectedStructure.id == draftSelected.id{
                for selectedStructureValues in selectedStructure.values!{
                    if selectedStructureValues.id == draftSelected.value as? Int{
                        return selectedStructureValues.title
                    }
                }
            }
        }
    }
    return ""
}


