//
//  Helper.swift
//  Vivora
//
//  Created by Andoni Da silva on 24/5/22.
//

import Foundation
import CryptoSwift

enum Helper {
    static func generateHash(withPublicKey publicKey: String, andPrivateKey privateKey: String) -> String {
        (BuildConfiguration.shared.ts + privateKey + publicKey).md5()
    }

    static var decoder: JSONDecoder {
        JSONDecoder()
    }

    static func decode<T: Decodable>(_ data: Data, completion: @escaping ((T) -> Void)) {
        do {
            let model = try decoder.decode(T.self, from: data)
            completion(model)
        } catch let DecodingError.dataCorrupted(context) {
            VivoraLog(DecodingError.dataCorrupted(context),
                          message: context.debugDescription,
                          tag: .decoding)
        } catch let DecodingError.keyNotFound(key, context) {
            VivoraLog(DecodingError.keyNotFound(key, context),
                          message: "Key '\(key)' not found:, \(context.debugDescription). codingPath: \(context.codingPath) 🚨",
                          tag: .decoding)
        } catch let DecodingError.valueNotFound(value, context) {
            VivoraLog(DecodingError.valueNotFound(value, context),
                          message: "Value '\(value)' not found:, \(context.debugDescription). codingPath: \(context.codingPath) 🚨",
                          tag: .decoding)
        } catch let DecodingError.typeMismatch(type, context)  {
            VivoraLog(DecodingError.typeMismatch(type, context),
                          message: "Type '\(type)' mismatch:, \(context.debugDescription). codingPath: \(context.codingPath) 🚨",
                          tag: .decoding)
        } catch let error {
            VivoraLog(error,
                          message: "Error decoding json 🚨",
                          tag: .decoding)
        }
    }
}
