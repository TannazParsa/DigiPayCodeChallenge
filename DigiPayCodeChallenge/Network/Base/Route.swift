//
//  Route.swift
//  DigiPayCodeChallenge
//
//  Created by tanaz on 24/04/1400 AP.
//

import Foundation

enum BaseURL: String {
    case baseUrl = "https://pro-api.coinmarketcap.com"
}

enum Router {
    case BaseServiceRoute(BaseRout)
}

extension Router {
    var url: String {
        switch self {
        case .BaseServiceRoute(let baseRoute):
            return baseRoute.path
      }
    }
}
