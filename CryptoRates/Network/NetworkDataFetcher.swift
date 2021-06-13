import Foundation
import  UIKit

class NetworkDataFetcher {
    
    static var instance: NetworkDataFetcher = {
        let instance = NetworkDataFetcher()
        return instance
    }()
    
    private init() {}
    
    private func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            
        }.resume()
    }
    
    func fetchQuotes(urlString: String, response: @escaping (Quote?) -> Void) {
        request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let recievedData = try JSONDecoder().decode(Quote.self, from: data)
                    response(recievedData)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
            }
        }
    }
    
   
    
    func fetchHist (urlString: String, response: @escaping (Historical) -> Void) {
        request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let recievedData = try JSONDecoder().decode(Historical.self, from: data)
                    response(recievedData)
            
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
            }
        }
    }
    
}

extension NetworkDataFetcher: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
