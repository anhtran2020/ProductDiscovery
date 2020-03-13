//
//  NestedJSONDecoder.swift
//  NetworkModule
//
//  Created by David Tran on 3/13/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Alamofire

//This is a convenience decoder, actually it's not very good in performance point of view, but it's very handy
class NestedJSONDecoder: DataDecoder {
    let keyPath: String
    let readingOptions: JSONSerialization.ReadingOptions
    let decoder: DataDecoder
    
    init(keyPath: String,
         decoder: DataDecoder,
         readingOptions: JSONSerialization.ReadingOptions) {
        self.keyPath = keyPath
        self.readingOptions = readingOptions
        self.decoder = decoder
    }
    
    func decode<D: Decodable>(_ type: D.Type, from data: Data) throws -> D {
        let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)
     
        guard let nestedJson = (json as AnyObject).value(forKeyPath: keyPath) else {
            throw NetworkError.responseSerializationFailed(reason: .nilDataAtKeyPath(keyPath: keyPath))
        }
        
        guard JSONSerialization.isValidJSONObject(nestedJson) else {
            throw NetworkError.responseSerializationFailed(reason: .invalidJSONAtKeyPath(keyPath: keyPath, value: nestedJson))
        }
        
        let nestedData = try JSONSerialization.data(withJSONObject: nestedJson)
        return try decoder.decode(type, from: nestedData)
    }
}
