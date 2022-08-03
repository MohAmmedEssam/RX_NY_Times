//
//  EndPoints.swift
//  Kamashka
//
//  Created by MohammedElhayes on 06/12/2021.
//

import Foundation
import Alamofire

enum EndPoints {
    case mostPopular(params: [String: Any])

}

class EndPointsProperties:URLConvertible {
    
    var endPoint:EndPoints
    
    init(_ endPoint:EndPoints) {
        self.endPoint = endPoint
    }
    deinit{
        
    }
    var method: HTTPMethod {
        switch endPoint {
        default :
            return .get
        }
    }

    var path: String {
        switch endPoint {
        case .mostPopular:
            return "mostpopular/v2/viewed/7.json"
        }
    }
    var requesType:RequesType{
        switch endPoint {
        default:
            return self.files.isEmpty ?  .normal:.upload
        }
    }
    
    var query: String {
        switch endPoint {
        case .mostPopular(let params):
            return params.queryString
        default:
            return ""
        }
    }
    
    var parameters: [String: Any] {
        switch endPoint {
        default:
            return [:]
        }
    }
    
    var files: [UploadFile]{
        switch endPoint {
        default:
            return []
        }
    }

    var headers:HTTPHeaders {
        return [
            .accept("application/json"),
            .acceptLanguage("en"),
        ]
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var baseUrl: String{
        switch endPoint{
        default:
            return ApiConstants.baseUrl
        }
    }
    
    var finalURL: String {
        let url = baseUrl + path + query
        return url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
    func asURL() throws -> URL {
        let urlRequest = URL(string: finalURL)!
        print("--------------------------------------------------------\n",
            "URL:         \(path)\n",
            "headers:     \(headers)\n",
            "params:      \(parameters)\n",
            "query:      \(query)\n",
            "files:       \(files)\n",
            "requesType:  \(requesType)",
            "\n--------------------------------------------------------")
        return  urlRequest
    }

}
