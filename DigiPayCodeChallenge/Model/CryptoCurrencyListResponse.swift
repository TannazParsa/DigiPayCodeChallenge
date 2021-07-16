//
//  cryptoCurrencyListResponse.swift
//  DigiPayCodeChallenge
//
//  Created by tanaz on 24/04/1400 AP.
//

import Foundation
struct CryptoCurrencyListResponse : Codable {
    
    let id : Int?
    let name : String?
    let symbol : String?
    let slug : String?
    let num_market_pairs : Int?
    let date_added : String?
    let tags : [String]?
    let quote : Quote?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case symbol = "symbol"
        case slug = "slug"
        case num_market_pairs = "num_market_pairs"
        case date_added = "date_added"
        case tags = "tags"
        case quote = "quote"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        num_market_pairs = try values.decodeIfPresent(Int.self, forKey: .num_market_pairs)
        date_added = try values.decodeIfPresent(String.self, forKey: .date_added)
        tags = try values.decodeIfPresent([String].self, forKey: .tags)
        quote = try values.decodeIfPresent(Quote.self, forKey: .quote)
    }
}
struct Quote : Codable {
    let uSD : USD?

    enum CodingKeys: String, CodingKey {

        case uSD = "USD"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uSD = try values.decodeIfPresent(USD.self, forKey: .uSD)
    }
}
struct USD : Codable {
    let price : Double?
    let volume_24h : Double?
    let percent_change_1h : Double?
    let percent_change_24h : Double?
    let percent_change_7d : Double?
    let percent_change_30d : Double?
    let percent_change_60d : Double?
    let percent_change_90d : Double?
    let market_cap : Double?
    let last_updated : String?

    enum CodingKeys: String, CodingKey {

        case price = "price"
        case volume_24h = "volume_24h"
        case percent_change_1h = "percent_change_1h"
        case percent_change_24h = "percent_change_24h"
        case percent_change_7d = "percent_change_7d"
        case percent_change_30d = "percent_change_30d"
        case percent_change_60d = "percent_change_60d"
        case percent_change_90d = "percent_change_90d"
        case market_cap = "market_cap"
        case last_updated = "last_updated"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        volume_24h = try values.decodeIfPresent(Double.self, forKey: .volume_24h)
        percent_change_1h = try values.decodeIfPresent(Double.self, forKey: .percent_change_1h)
        percent_change_24h = try values.decodeIfPresent(Double.self, forKey: .percent_change_24h)
        percent_change_7d = try values.decodeIfPresent(Double.self, forKey: .percent_change_7d)
        percent_change_30d = try values.decodeIfPresent(Double.self, forKey: .percent_change_30d)
        percent_change_60d = try values.decodeIfPresent(Double.self, forKey: .percent_change_60d)
        percent_change_90d = try values.decodeIfPresent(Double.self, forKey: .percent_change_90d)
        market_cap = try values.decodeIfPresent(Double.self, forKey: .market_cap)
        last_updated = try values.decodeIfPresent(String.self, forKey: .last_updated)
    }
}
