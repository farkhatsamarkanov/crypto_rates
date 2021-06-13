
import Foundation

// MARK: - Quote
struct Quote: Codable {
    let data: [Datum]
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let coinInfo: CoinInfo
    let raw: Raw
    let display: Display
    
    enum CodingKeys: String, CodingKey {
        case coinInfo = "CoinInfo"
        case raw = "RAW"
        case display = "DISPLAY"
    }
}

// MARK: - CoinInfo
struct CoinInfo: Codable {
    let name, fullName, imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case fullName = "FullName"
        case imageURL = "ImageUrl"
    }
}

// MARK: - Raw
struct Raw: Codable {
    let usd: RawUsd
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - RawUsd
struct RawUsd: Codable {
    let lastupdate: Int
    let price: Double
    enum CodingKeys: String, CodingKey {
        case lastupdate = "LASTUPDATE"
        case price = "PRICE"
    }
}

// MARK: - Display
struct Display: Codable {
    let usd: DisplayUsd
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - DisplayUsd
struct DisplayUsd: Codable {
    let fromsymbol, price, volume24Hour, volume24Hourto, open24Hour, high24Hour, low24Hour, changepct24Hour, supply, mktcap, totalvolume24H, totalvolume24Hto: String
    let tosymbol: String
    
    enum CodingKeys: String, CodingKey {
        case fromsymbol = "FROMSYMBOL"
        case tosymbol = "TOSYMBOL"
        case price = "PRICE"
        case volume24Hour = "VOLUME24HOUR"
        case volume24Hourto = "VOLUME24HOURTO"
        case open24Hour = "OPEN24HOUR"
        case high24Hour = "HIGH24HOUR"
        case low24Hour = "LOW24HOUR"
        case changepct24Hour = "CHANGEPCT24HOUR"
        case supply = "SUPPLY"
        case mktcap = "MKTCAP"
        case totalvolume24H = "TOTALVOLUME24H"
        case totalvolume24Hto = "TOTALVOLUME24HTO"
    }
}

