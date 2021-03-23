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
    
    private func readLocalFile(forName name: String) -> [[String: Any]]? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [[String: Any]]
                return json
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(json: [[String: Any]])  {
        
    }
    
    func getDoodles() -> [Doodle] {
        guard let doodlesData = self.readLocalFile(forName: "doodle") else { return [] }
        parse(jsonData: doodlesData)
        
        return self.doodles
    }
}
