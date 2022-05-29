//
//  Environment.swift
//  Vivora
//
//  Created by Andoni Da silva on 24/5/22.
//

import Foundation

enum Environment: String {
    case debugDevelopment = "Debug Development"
    case releaseDevelopment = "Release Development"

    case debugProduction = "Debug Production"
    case releaseProduction = "Release Production"
}

struct BuildConfiguration {
    static let shared = BuildConfiguration()

    let ts = "44"

    var environment: Environment

    var publicKey: String {
        switch environment {
            case .debugDevelopment:
                return "b08158b5861496ae6074d19fd8013401"
            case .releaseDevelopment:
                return "b08158b5861496ae6074d19fd8013401"
            case .debugProduction:
                return "b08158b5861496ae6074d19fd8013401"
            case .releaseProduction:
                return "b08158b5861496ae6074d19fd8013401"
        }
    }

    var privateKey: String {
        switch environment {
            case .debugDevelopment:
                return "73d340ca7c3639e0287f15b2d922a26bd83f0ddb"
            case .releaseDevelopment:
                return "73d340ca7c3639e0287f15b2d922a26bd83f0ddb"
            case .debugProduction:
                return "73d340ca7c3639e0287f15b2d922a26bd83f0ddb"
            case .releaseProduction:
                return "73d340ca7c3639e0287f15b2d922a26bd83f0ddb"
        }
    }

    init() {
        guard
            let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "EnvironmentConf") as? String,
            let env = Environment(rawValue: currentConfiguration)
        else {
            environment = .debugDevelopment
            return
        }
        environment = env
    }
}

protocol EndPoint {
    var scheme: String { get }
    var urlBase: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parametersUrl: [URLQueryItem]? { get }
    var body: Data? { get }
    var contentType: ContentType? { get }
    var headers: [String: String] { get }
}

enum VivoraEndPoint: EndPoint {
    case getCharacters(nameStart: String = "", limit: String = "15", offset: String)
    case getDetail(characterID: String)
    case getStory(id: String)
    case getEvent(id: String)
    case getComic(id: String)

    static var hash: String {
        Helper.generateHash(withPublicKey: BuildConfiguration.shared.publicKey,
                                       andPrivateKey: BuildConfiguration.shared.privateKey)
    }

    private enum VivoraParamNames: String {
        case ts
        case apikey
        case hash
        case nameStartsWith
        case limit
        case offset
    }

    var scheme: String {
        switch self {
            case .getCharacters, .getDetail, .getComic, .getEvent, .getStory:
                return "https"
        }
    }

    var urlBase: String {
        switch BuildConfiguration.shared.environment {
            case .debugDevelopment, .debugProduction, .releaseProduction, .releaseDevelopment:
                return "gateway.marvel.com"
        }
    }

    var path: String {
        switch self {
            case .getDetail(let characterID):
                return "/v1/public/characters/\(characterID)"
            case .getCharacters:
                return "/v1/public/characters"
            case .getEvent(let id):
                return "/v1/public/events/\(id)"
            case .getComic(let id):
                return "/v1/public/comics/\(id)"
            case .getStory(let id):
                return "/v1/public/stories/\(id)"
        }
    }

    var method: HTTPMethod {
        switch self {
            default:
                return .GET
        }
    }

    var parametersUrl: [URLQueryItem]? {
        switch self {
            case .getCharacters(let nameStart, let limit, let offset):
                var queryParams = [URLQueryItem(name: VivoraParamNames.apikey.rawValue, value: BuildConfiguration.shared.publicKey), URLQueryItem(name: VivoraParamNames.hash.rawValue, value: VivoraEndPoint.hash), URLQueryItem(name: VivoraParamNames.offset.rawValue, value: offset), URLQueryItem(name: VivoraParamNames.limit.rawValue, value: limit), URLQueryItem(name: VivoraParamNames.ts.rawValue, value: BuildConfiguration.shared.ts)]
                guard !nameStart.isEmpty
                else {
                    return queryParams
                }
                queryParams.append(URLQueryItem(name: VivoraParamNames.nameStartsWith.rawValue, value: nameStart))
                return queryParams
            case .getDetail:
                return nil
            case .getStory, .getEvent, .getComic:
                let queryParams = [URLQueryItem(name: VivoraParamNames.apikey.rawValue, value: BuildConfiguration.shared.publicKey), URLQueryItem(name: VivoraParamNames.hash.rawValue, value: VivoraEndPoint.hash), URLQueryItem(name: VivoraParamNames.ts.rawValue, value: BuildConfiguration.shared.ts)]
                return queryParams
        }
    }

    var body: Data? {
        switch self {
            default:
                return nil
        }
    }

    var contentType: ContentType? {
        .json
    }

    // Return needed headers based on what you need from an environment
    var headers: [String : String] {
        [:]
    }
}

enum ContentType: String {
    case json = "application/json"
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}
