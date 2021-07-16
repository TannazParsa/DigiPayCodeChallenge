//
//  BaseResponse.swift
//  DigiPayCodeChallenge
//
//  Created by tanaz on 24/04/1400 AP.
//

import Foundation
import UIKit

enum Results<T> {
    case success(value: Codable)
    case failure(error: String)
}

public struct BaseResponse<T: Codable>: Codable {

    let status: Status?
    let data: T?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Status.self, forKey: .status)
        data = try values.decodeIfPresent(T.self, forKey: .data)
    }

}
struct Status : Codable {
    let timestamp : String?
    let error_code : Int?
    let error_message : String?
    let elapsed : Int?
    let credit_count : Int?
    let notice : String?
    let total_count : Int?

    enum CodingKeys: String, CodingKey {

        case timestamp = "timestamp"
        case error_code = "error_code"
        case error_message = "error_message"
        case elapsed = "elapsed"
        case credit_count = "credit_count"
        case notice = "notice"
        case total_count = "total_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        error_code = try values.decodeIfPresent(Int.self, forKey: .error_code)
        error_message = try values.decodeIfPresent(String.self, forKey: .error_message)
        elapsed = try values.decodeIfPresent(Int.self, forKey: .elapsed)
        credit_count = try values.decodeIfPresent(Int.self, forKey: .credit_count)
        notice = try values.decodeIfPresent(String.self, forKey: .notice)
        total_count = try values.decodeIfPresent(Int.self, forKey: .total_count)
    }
}
