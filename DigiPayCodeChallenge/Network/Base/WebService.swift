//
//  WebService.swift
//  naghsheh
//
//  Created by tanaz on 02/01/1400 AP.
//

import Foundation
import Alamofire
import RxSwift
class WebServices {



    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?) -> Void
    private var requestsToRetry: [RequestRetryCompletion] = []
    static let shared = WebServices()

    private var isRefreshing = false

    var accessToken:String? = ""
    var refreshToken:String? = ""
    private let lock = NSLock()
    var needAuth = false
    var sessionManager:SessionManager!

    init() {
        sessionManager = Alamofire.SessionManager.default
    }

//    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
//        var urlRequest = urlRequest
//        if let urlString = urlRequest.url?.absoluteString, !urlString.hasPrefix(Router.BaseServiceRoute(BaseRout.refreshToken).url){
//        }
//        return urlRequest
//    }
    // MARK: - Private - Refresh Tokens
//    private func refreshTokens(completion: @escaping RefreshCompletion) {
//        guard !isRefreshing else { return }
//        isRefreshing = true
//
//        let urlString = Router.BaseServiceRoute(BaseRout.refreshToken).url
//        Alamofire.request(urlString, method: .post, parameters: ["authorization": refreshToken!], encoding: JSONEncoding.default, headers: nil).responseJSON { [weak self] response in
//            guard let strongSelf = self else { return }
//            print(response.result.value)
//            if
//                let json = response.result.value as? [String: Any],
//                let accessToken = json["body"] as? [String: Any]
//            {
//                print(accessToken)
//                if let token = accessToken["token"] as? String {
//                    print(token)
//                    //   StoringData.token = token
//                    completion(true, token)
//                }
//            } else {
//                completion(false, nil)
//            }
//            strongSelf.isRefreshing = false
//        }
//    }

//    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
//        lock.lock() ; defer { lock.unlock() }
//        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
//            requestsToRetry.append(completion)
//            if !isRefreshing {
//                refreshTokens { [weak self] succeeded, accessToken in
//                    guard let strongSelf = self else { return }
//
//                    strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
//
//                    if let accessToken = accessToken {
//                        strongSelf.accessToken = accessToken
//                    }
//
//                    strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
//                    strongSelf.requestsToRetry.removeAll()
//                }
//            }
//        } else {
//            completion(false, 0.0)
//        }
//    }

    func requestWithArrayResponse<T:Codable>(url: String,
                                             param: Parameters? = nil,
                                             method: HTTPMethod = .post,
                                             encoding: ParameterEncoding = JSONEncoding.default) -> Observable<Results<[T]>> {
        print(">>> Service : " ,url , ":::" ,param as Any)
        let observer = PublishSubject<Results<[T]>>()
        var header = [String:String]()
        header["X-CMC_PRO_API_KEY"] = "1f41809d-4d30-44da-892f-bda4628948c8"
        print(header)
        Alamofire.request(
            url,
            method: method,
            parameters: param,
            encoding: encoding,
            headers: header
        )
        .responseArray(completionHandler: { (response: DataResponse<BaseResponse<[T]>>) in

            let json = try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [String : Any]
            print(json as Any)
            print(response)
            switch response.result {
            case .success(let array):
                debugPrint(array)
                observer.onNext(Results.success(value: array))
                debugPrint("🌹", array)
            case .failure(let error):
                debugPrint("🌹", error.localizedDescription)
                guard let jsonData = response.data else {
                    print("is nil")
                    return}
                let error = try? JSONDecoder().decode([String:[String]].self, from: jsonData)
                print(error)
                observer.onNext(Results.failure(error: error?.values.first?.first ?? ""))
            }
        })
        return observer
    }

    func request<T: Codable>(url: String,
                             param: Parameters? = nil,
                             method: HTTPMethod = .post,
                             encoding: ParameterEncoding = JSONEncoding.default
    ) -> Observable<Results<T>> {
        print(">>> Service : " ,url , ":::" ,param as Any)
        let observer = PublishSubject<Results<T>>()
        var header = [String:String]()
        header["X-CMC_PRO_API_KEY"] = "1f41809d-4d30-44da-892f-bda4628948c8"
        Alamofire.request(url, method: method, parameters: param, encoding: encoding, headers: header)
            .validate()
            .responseObject{ (response: DataResponse<T>) in
                print(response.data)
                print(response.response?.statusCode)
                let json = try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [String : Any]
                print(json as Any)
                let successful = (200..<300).contains(response.response?.statusCode ?? 0)
                guard let jsonData = response.data, let articleContent = try?  JSONDecoder().decode(BaseResponse<T>.self, from: jsonData) else {
                    return}
                print(articleContent)
                switch response.result {
                case .success(let object):
                    debugPrint(object)
                    observer.onNext(Results.success(value: articleContent))
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    guard let jsonData = response.data else {
                        print("is nil")
                        return}
                    let error = try? JSONDecoder().decode(BaseResponse<T>.self, from: jsonData)
                    print(error)
                    observer.onNext(Results.failure(error: error?.status?.error_message ?? ""))
                }
            }
        return observer

    }
}


