//
//  NetworkLayer.swift
//  Kamashka
//
//  Created by MohammedElhayes on 06/12/2021.
//

import Foundation
import Alamofire
import RxSwift

//  MARK: - NetworkLayer Alamofire
class NetworkLayer {
    private var endPoint:EndPointsProperties!
    
    var requestProgress: ((Float)->Void)?
    var supportWithOurModel: Bool
    
    init(_ endPoint: EndPoints, supportWithOurModel: Bool = true) {
        print("NetworkLayer init")
        self.supportWithOurModel = supportWithOurModel
        self.endPoint = EndPointsProperties(endPoint)
    }
    deinit {
        print("NetworkLayer deinit")
    }

    // For normal and uplaod requests
    func request<T: Codable>()-> Observable<T?> {
        return Observable.create { observable -> Disposable in
 
            switch self.endPoint.requesType {
            case .upload:
                self.uploadRequest(observable)
            case .normal:
                self.normalRequest(observable)
            default:
                break
            }
            
            return Disposables.create{}
        }
    }
    //For Download only
    func request()-> Observable<URL?> {
        return Observable.create { observable -> Disposable in
            self.downloadRequest(observable)
            return Disposables.create{}
        }
    }
}

//  MARK: - Request Types
extension NetworkLayer{
    //Normal
    private func normalRequest<T: Codable>(_ observable:AnyObserver<T?>){
        AF.request(self.endPoint,
                method: self.endPoint.method,
                parameters: self.endPoint.parameters,
                encoding: self.endPoint.encoding,
                headers: self.endPoint.headers,
                interceptor: self
        ).response {//.responseDecodable { (response: AFDataResponse<T>) in
            
            self.handleResponse(observable,$0)
        }
    }
    //Upload
    private func uploadRequest<T: Codable>(_ observable:AnyObserver<T?>){
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in self.endPoint.parameters {
                multipartFormData.append(("\(value)".data(using: .utf8))!, withName: key)
            }
            for file in self.endPoint.files {
                multipartFormData.append(file.data, withName: file.key,fileName: file.name, mimeType: file.type.rawValue)
            }

        } ,
        to: endPoint,
        usingThreshold: UInt64(),
        method: self.endPoint.method,
        headers: endPoint.headers,
        interceptor: self
        )
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .response {//.responseDecodable { (response: AFDataResponse<T>) in
            self.handleResponse(observable,$0)
        }
    }
    //Download
    private func downloadRequest(_ observable:AnyObserver<URL?>){
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        AF.download(endPoint,to: destination).downloadProgress(closure: { (progress) in
            print("===>>>DownloadProgress: \(Float(progress.fractionCompleted))")
            self.requestProgress?(Float(progress.fractionCompleted))
        }).response { (response) in
            self.handleResponse(observable,response)
        }
    }

    //MARK: - handle Response

    private func handleResponse<T: Codable>(_ observable:AnyObserver<T?>, _ response:AFDataResponse<Data?>){
        
            switch response.result {
            
            //MARK: response success
            case .success(let value):
                
                print("--------------------------------------------------------\n",
                      "URL: \(self.endPoint.path)\n",
                      "response.result: \n",value?.toString ?? "",
                      "\n--------------------------------------------------------")
                if let value = value{
                    
                    //MARK: Auth &&  success
                    if response.response?.statusCode == 200{
                        
                        //MARK: Decode BackEndModel
                        if self.supportWithOurModel{
                            let (model,error) = value.Decode(BackEndModel<T>.self)
                            if let model = model{
                                if model.isSuccess{
                                    observable.onNext(model.payload?.data)
                                    observable.onCompleted()
                                }else{
                                    observable.onError(AppError.other(msg: model.errorMessage))
                                    observable.onCompleted()
                                }

                            }else if let error = error{
                                observable.onError(error)
                                observable.onCompleted()
                            }

                            //MARK: Decode given model
                        }else{
                            let (model,error) = value.Decode(T.self)
                            if let model = model{
                                observable.onNext(model)
                                observable.onCompleted()

                            }else if let error = error{
                                observable.onError(error)
                                observable.onCompleted()
                            }
                        }
                        
                    }
                    
                    //MARK: Not Auth
                    else if response.response?.statusCode == 401{
                        self.logOut()
                        observable.onCompleted()
                    }
                    
                    //MARK: Error
                    else{
                        let (model,error) = value.Decode(BackEndModel<IgnoredData?>.self)
                        if let model = model{
                            observable.onError(AppError.other(msg: model.errorMessage))
                            observable.onCompleted()

                        }else if let error = error{
                            observable.onError(error)
                            observable.onCompleted()
                        }
                    }
                    
                }else{
                    observable.onError(AppError.other(msg: "No data exist"))
                    observable.onCompleted()
                }
            
            //MARK: response failure
            case .failure(let error):
                
                print("--------------------------------------------------------\n",
                      "URL: \(self.endPoint.path)\n",
                      "response.error :( \n",error.localizedDescription,
                      "\n--------------------------------------------------------")
                observable.onError(error)
                observable.onCompleted()
                break

            }
    }
    
    //MARK: download
    private func handleResponse(_ observable:AnyObserver<URL?>, _ response:AFDownloadResponse<URL?>){
        switch response.result {
        case .success(let value):
            
            print("--------------------------------------------------------\n",
                  "URL: \(self.endPoint.path)\n",
                  "response.result: \n",value,
                  "\n--------------------------------------------------------")
            observable.onNext(value)
            observable.onCompleted()
            break
            
        case .failure(let error):
            
            print("--------------------------------------------------------\n",
                  "URL: \(self.endPoint.path)\n",
                  "response.error :( \n",error.localizedDescription,
                  "\n--------------------------------------------------------")
            observable.onError(error)
            observable.onCompleted()
            break
        }
    }
}
//MARK: - RequestInterceptor

extension NetworkLayer:RequestInterceptor{
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
      completion(.retryWithDelay(5))
    }
}

//MARK: - Actions

extension NetworkLayer{
    private func logOut(){
        
    }
}
