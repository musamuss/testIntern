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
      //let structureJSON = loadJson(filename: "Structure")
       let draftJSON = loadJson(filename: "Draft_values")
       
        //let structureMap = RequestCodable(json: structureJSON!)
        let draftMap = Draft(json: draftJSON!)
        dump(draftMap)
       // dump(draftMap)
//        for draft in ((draftMap?.values)!) {
//            for var structure in (structureMap?.params)! {
//                if draft.id == structure.id {
//                    if type(of: draft.value) == Int.self {
//                    structure.value = poisk(id: draft.id)
//                    print("uspeh")
//                        print(draft)
//                        break
//                    } else { structure.value = draft.value as? String
//                    }
//                } else {print("net")}
//            }
//        }
        
        }
    }
    
    


func poisk(id:Int) -> String {
    let structureJSON = loadJson(filename: "Structure")
    let structureMap = RequestCodable(json: structureJSON!)
    
    for requestcodable in (structureMap?.params)! {
        if requestcodable.id == id {
            return requestcodable.title
                } else {
        for structure in requestcodable.values! {
            if structure.id == id {
                return structure.title
                    } else {
                    for structurevalue in structure.params! {
                                if structurevalue.id == id {
                                    return structurevalue.title
                                    
                                } else {
        for params in structurevalue.values!{
            if params.id == id {
                return params.title
                
            }
                                }
                        }
            }
                }
    }
}
}
    return "kek"
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

