//
//  CryptoServices.swift
//  naghsheh
//
//  Created by tannaz on 5/8/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Alamofire

struct CryptoServices {
    static var shared = CryptoServices()
    
    func getLatestCryptoList(start: Int, limit: Int, sort: String? = nil, sortDir: String? = nil, tag: String? = nil, cryptoType: String? = nil) -> Observable<Results<[CryptoCurrencyListResponse]>> {
        var params = ["start": start,
                      "limit": limit] as [String : Any]
        if sort != nil {
            params["sort"] = sort
        }
        if sortDir != nil {
            params["sort_dir"] = sortDir
        }
        if tag != nil {
            params["tag"] = tag
        }
        if cryptoType != nil {
            params["cryptocurrency_type"] = cryptoType
        }
        return WebServices.shared.requestWithArrayResponse(url: Router.BaseServiceRoute(BaseRout.cryptoLatestListings).url,param: params, method: .get, encoding: URLEncoding.default)
    }

    func getCryptoCurrencyDetails(id: String) -> Observable<Results<DataInfo>> {
        let params = ["id": id]
        return WebServices.shared.request(url: Router.BaseServiceRoute(BaseRout.cryptoInfo).url , param: params, method: .get, encoding: URLEncoding.default)
    }
}

