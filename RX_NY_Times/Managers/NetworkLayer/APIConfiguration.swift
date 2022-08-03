//
//  APIConfiguration.swift
//  Kamashka
//
//  Created by MohammedElhayes on 06/12/2021.
//

import Foundation
import RxSwift
import UIKit

// MARK: - enums
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case contentLength = "content-length"
}
enum RequesType {
    case normal
    case upload
    case download
}
enum RequestMethod:String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
enum AppError: Error {
    case normal
    case other(msg:String)

    var errorMessage:String{
        switch self {
        case .other(let msg):
            return msg

        default:
            return self.localizedDescription
        }
    }
}
extension Error{
    var errorMessage:String{
        if let err = self as? AppError{
            return err.errorMessage

        }else{
            return self.localizedDescription

        }
    }
}
// MARK: - UploadFile model
struct UploadFile:Codable {
    var data: Data//data: file
    var key: String = "asset"//key: parameter name
    var name: String = "asset_\(Int((Date().timeIntervalSince1970) * 1000))"//name: filename
    var type: UploadFileType = .image//type: extension (image/png, image/jpeg, etc)
}
enum UploadFileType:String,Codable{
    case image = "image/jpeg"
    case video = "video/mp4"
}

////-----------------------------------------------------------------------
////  MARK: - Extensions
////-----------------------------------------------------------------------
extension Dictionary {
    var queryString:String {
        var urlVars:[String] = []
        for (key, value) in self {
            if value is Array<Any> {
                for v in value as! Array<Any> {
                    if let encodedValue = "\(v)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                        urlVars.append((key as! String) + "[]=" + encodedValue)
                    }
                }
            }else{
                if let val = value as? String {
                    if let encodedValue = val.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                        urlVars.append((key as! String) + "=" + encodedValue)
                    }
                }else{
                    urlVars.append((key as! String) + "=\(value)")
                }
            }
        }
        return urlVars.isEmpty ? "" : "?\(urlVars.joined(separator: "&"))"
    }
    
    
}
//-----------------------------------------------------------------------
//  MARK: - Decoder
//-----------------------------------------------------------------------
extension Data {
    func Decode<T: Codable> (_ object:T.Type) ->(T?,Error?) {
       do {
           let decoder = JSONDecoder()
           let DataResponsed = try decoder.decode(T.self, from: self)
           return(DataResponsed, nil)
       } catch {
            print("-> Entity: " + String(describing: T.self))
            print("-> Error: " + String(describing: error))
            return (nil, error)
       }
    }
    
    var toString:String {
        return String(data: self, encoding: .utf8) ?? ""
    }
}
extension Encodable {
    var asDictionary:[String: Any] {
        let serialized = (try? JSONSerialization.jsonObject(with: self.encoded, options: .allowFragments)) ?? nil
        return serialized as? [String: Any] ?? [String: Any]()
    }
    
    var encoded:Data {
        return (try? JSONEncoder().encode(self)) ?? Data()
    }
}

//-----------------------------------------------------------------------
//  MARK: - GenericResponseModel
//-----------------------------------------------------------------------
struct BackEndModel<T: Codable>: Codable {
    let error: Int?
    let message: String?
    let payload:ResponseData<T>?
    
    var isSuccess:Bool{
        return(error == 0)
    }
    var errorMessage:String{
        return (message ??  "Unknown error")
    }
}
struct ResponseData<T: Codable>: Codable {
    let data: T?
}
struct IgnoredData: Codable {}
//-----------------------------------------------------------------------
//  MARK: - common params
//-----------------------------------------------------------------------
struct CommonParams: Codable {
    var operating_system:String = "ios"
    
}

//-----------------------------------------------------------------------
//  MARK: - Flexible Decoding
//-----------------------------------------------------------------------
@propertyWrapper
struct StringForcible: Codable {
    
    var wrappedValue: String?
    
    enum CodingKeys: CodingKey {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            wrappedValue = string
        } else if let integer = try? container.decode(Int.self) {
            wrappedValue = "\(integer)"
        } else if let double = try? container.decode(Double.self) {
            wrappedValue = String(format: "%.1f",double)
        } else if container.decodeNil() {
            wrappedValue = nil
        }
        else {
            throw DecodingError.typeMismatch(String.self, .init(codingPath: container.codingPath, debugDescription: "Could not decode incoming value to String. It is not a type of String, Int or Double."))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
    
    init() {
        self.wrappedValue = nil
    }
    
}

/*
*-------------------
* >> ApiConstants
*-------------------
*/
struct ApiConstants {

    //eng.mohammedessam@gmail.com
    //ZW56q.LyUjU6*9Q
    static let baseUrl = "https://api.nytimes.com/svc/"
    static let apiKey = "CqM7B7cpRU6GtV2iI8mMD1Y8885RCkQ4"

}
