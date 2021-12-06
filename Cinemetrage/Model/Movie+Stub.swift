//
//  Movie+Stub.swift
//  Cinemetrage
//
//  Created by Fernando Pérez Ruiz on 04/12/21.
//

import Foundation

extension Movie {
    static var stubbedMovies : [Movie] {
        let response : MovieResponse = try Bundle.main.readAndDecodeJSON(file: "upcoming") as! MovieResponse
        return response.results
    }
    
    static var stubbedMovie : Movie {
        stubbedMovies[0]
    }
}


extension Bundle {
    
    //Logic for reading our local JSON File fileName as argument
    func readAndDecodeJSON(file fileName: String) -> Decodable{
        do {
            //Safely get our bundlePath and safely try to get Data from our bundlePath
            print("We are runing \(#function) + \(fileName)")
            if let bundlePath = Bundle.main.path(forResource: fileName, ofType: "json"),  let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {

                let decodedData = parseData(jsonData: jsonData)
                
                return decodedData
            }
        } catch {
            print("error getting JSON Data \(error)")
        }
        //No JSON Data Back
        print("No JSONData Back")
        return ""
    }
    
    //Method for parsing JSONData
    func parseData(jsonData : Data) -> Decodable{
        let decoder = Utilities.jsonDecoder
        //Try to decode our jsonData
        do {
            let decodedData = try decoder.decode(Data.self, from: jsonData)
            print("decoded Data \(decodedData)")
            return decodedData
        } catch {
            print("error decoding data")
        }
        return ""
    }
}
