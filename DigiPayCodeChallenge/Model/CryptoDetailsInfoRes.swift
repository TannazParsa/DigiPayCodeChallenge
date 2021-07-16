//
//  CryptoDetailsInfoRes.swift
//  DigiPayCodeChallenge
//
//  Created by tanaz on 25/04/1400 AP.
//

import Foundation
struct DetailsInfo: Codable {
    let id : Int?
    let name : String?
    let symbol : String?
    let category : String?
    let description : String?
    let slug : String?
    let logo : String?
    let subreddit : String?
    let notice : String?
    let tags : [String]?
    let urls : Urls?
    let platform : String?
    let date_added : String?
    let twitter_username : String?
    let is_hidden : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case symbol = "symbol"
        case category = "category"
        case description = "description"
        case slug = "slug"
        case logo = "logo"
        case subreddit = "subreddit"
        case notice = "notice"
        case tags = "tags"
        case urls = "urls"
        case platform = "platform"
        case date_added = "date_added"
        case twitter_username = "twitter_username"
        case is_hidden = "is_hidden"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        logo = try values.decodeIfPresent(String.self, forKey: .logo)
        subreddit = try values.decodeIfPresent(String.self, forKey: .subreddit)
        notice = try values.decodeIfPresent(String.self, forKey: .notice)
        tags = try values.decodeIfPresent([String].self, forKey: .tags)
        urls = try values.decodeIfPresent(Urls.self, forKey: .urls)
        platform = try values.decodeIfPresent(String.self, forKey: .platform)
        date_added = try values.decodeIfPresent(String.self, forKey: .date_added)
        twitter_username = try values.decodeIfPresent(String.self, forKey: .twitter_username)
        is_hidden = try values.decodeIfPresent(Int.self, forKey: .is_hidden)
    }
}

struct DataInfo: Codable {
    let details: [String: DetailsInfo]?

}
struct Urls : Codable {
    let website : [String]?
    let twitter : [String]?
    let message_board : [String]?
    let chat : [String]?
    let explorer : [String]?
    let reddit : [String]?
    let technical_doc : [String]?
    let source_code : [String]?
    let announcement : [String]?

    enum CodingKeys: String, CodingKey {

        case website = "website"
        case twitter = "twitter"
        case message_board = "message_board"
        case chat = "chat"
        case explorer = "explorer"
        case reddit = "reddit"
        case technical_doc = "technical_doc"
        case source_code = "source_code"
        case announcement = "announcement"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        website = try values.decodeIfPresent([String].self, forKey: .website)
        twitter = try values.decodeIfPresent([String].self, forKey: .twitter)
        message_board = try values.decodeIfPresent([String].self, forKey: .message_board)
        chat = try values.decodeIfPresent([String].self, forKey: .chat)
        explorer = try values.decodeIfPresent([String].self, forKey: .explorer)
        reddit = try values.decodeIfPresent([String].self, forKey: .reddit)
        technical_doc = try values.decodeIfPresent([String].self, forKey: .technical_doc)
        source_code = try values.decodeIfPresent([String].self, forKey: .source_code)
        announcement = try values.decodeIfPresent([String].self, forKey: .announcement)
    }
}
