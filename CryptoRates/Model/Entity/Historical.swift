import Foundation

// MARK: - Historical
struct Historical: Decodable {
    let data: DataClass
    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

// MARK: - DataClass
struct DataClass: Decodable {
    let data: [HistoricalDatum]
    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

// MARK: - Datum
struct HistoricalDatum: Decodable {
    var time: Int
    var close: Double
}
