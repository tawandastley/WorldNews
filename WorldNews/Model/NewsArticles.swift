
import Foundation

struct NewsArticles: Codable {

  var status       : String?     = nil
  var totalResults : Int?        = nil
  var articles     : [Articles]? = []

  enum CodingKeys: String, CodingKey {

    case status       = "status"
    case totalResults = "totalResults"
    case articles     = "articles"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    status       = try values.decodeIfPresent(String.self     , forKey: .status       )
    totalResults = try values.decodeIfPresent(Int.self        , forKey: .totalResults )
    articles     = try values.decodeIfPresent([Articles].self , forKey: .articles     )
 
  }

  init() {

  }

}