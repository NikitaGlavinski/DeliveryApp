//
//  DictionaryHelpper.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/24/21.
//

import Foundation

class DictionaryEncoder {
    
    private let encoder = JSONEncoder()
    
    func encode<T: Encodable>(_ value: T) throws -> [String: Any] {
        let data = try encoder.encode(value)
        return try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as! [String: Any]
    }
}

class DictionaryDecoder {
    
    private let decoder = JSONDecoder()
    
    func decode<T: Decodable>(_ dictionary: [String: Any], decodeType: T.Type) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        return try decoder.decode(decodeType, from: data)
    }
}
