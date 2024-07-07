import Foundation

protocol APIManagerProtocol {
    func fetchImage(completion: @escaping (Result<[ImageModel], Error>) -> Void)
}

final class APIManager: APIManagerProtocol {
    func fetchImage(completion: @escaping (Result<[ImageModel], Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "invald URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "no data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let photos = try JSONDecoder().decode([ImageModel].self, from: data)
                completion(.success(photos))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
