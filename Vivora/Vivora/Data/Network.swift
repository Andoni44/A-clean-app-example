//
//  Network.swift
//  Vivora
//
//  Created by Andoni Da silva on 24/5/22.
//

import Foundation

enum NetworkError: Error {
    case noNetwork
    case problem
    case error
    case serverError
    case auth
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .noNetwork:
                return NSLocalizedString("Check your internet connection", comment: "")
            case .problem:
                return NSLocalizedString("There is a problem with your request", comment: "")
            case .error:
                return NSLocalizedString("Error", comment: "")
            case .serverError:
                return NSLocalizedString("Error with the server", comment: "")
            case .auth:
                return NSLocalizedString("Your credentials are invalid", comment: "")
        }
    }
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

// Decouple session from URLSession
protocol ApiFactoryProtocol {
    var session: URLSessionProtocol { get set }

    func getData<T: Decodable>(fromEndPoint endPoint: EndPoint,
                               completion: @escaping ((Result<T, NetworkError>) -> Void))
}


struct ApiFactory: ApiFactoryProtocol {
    var session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func getData<T>(fromEndPoint endPoint: EndPoint,
                    completion: @escaping ((Result<T, NetworkError>) -> Void)) where T : Decodable {
        guard let request = generateRequest(fromEndpoint: endPoint) else { return }
        VivoraLog("New request 🛰: \(request.url?.absoluteString ?? "")", tag: .networking)
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse
            else {
                guard let error = error as NSError? else { return }
                if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                    completion(.failure(.noNetwork))
                    VivoraLog(error, message: "No network 🚨", tag: .networking)
                    return
                }
                VivoraLog(error, message: "Network problem 🚨", tag: .networking)
                completion(.failure(.problem))
                return
            }
            switch response.statusCode {
                case 200:
                    Helper.decode(data) { dto in
                        completion(.success(dto))
                    }
                case 409:
                    VivoraLog("Error 🚨", level: .debug, tag: .networking)
                    completion(.failure(.serverError))
                default:
                    VivoraLog("Server error 🚨", level: .debug, tag: .networking)
                    completion(.failure(.serverError))
            }
        }.resume()
    }
}

// MARK: - Request setup

private extension ApiFactory {
    func generateRequest(fromEndpoint endpoint: EndPoint) -> URLRequest? {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.urlBase
        components.path = endpoint.path

        components.queryItems = endpoint.parametersUrl

        guard let url = components.url else { return nil }

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = endpoint.method.rawValue

        urlRequest.httpBody = endpoint.body

        endpoint.headers.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }

        guard let contentType = endpoint.contentType else { return urlRequest }

        switch contentType {
            case .json:
                urlRequest.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        }
        return urlRequest
    }
}
