//
//  JsonParser.swift
//  PhotosApp
//
//  Created by zombietux on 2021/03/23.
//

import Foundation

class JsonParser {
    private var doodles: [Doodle]
    
    init() {
        self.doodles = []
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func parse(withCompletion completion:@escaping ([Doodle]) -> ()) {
        let decoder = JSONDecoder()
        
        do {
            let doodles = try decoder.decode([Doodle].self, from: readLocalFile(forName: "doodle") ?? Data())
            completion(doodles)
        } catch {
            print(error.localizedDescription)
        }
    }
}
