//
//  ServiceRoute.swift
//  DigiPayCodeChallenge
//
//  Created by tanaz on 24/04/1400 AP.
//

import Foundation

enum BaseRout: String {

    case cryptoLatestListings = "/v1/cryptocurrency/listings/latest"
    case cryptoInfo = "/v1/cryptocurrency/info"
    

  var path: String {
    return BaseURL.baseUrl.rawValue + self.rawValue
  }
}
