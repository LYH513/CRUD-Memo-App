//
//  NetworkManager.swift
//  5th-SwiftUI-URLSession
//
//  Created by 이유현 on 3/3/25.
//

import Foundation

enum NetworkService {
    
    // baseUrl 설정
    enum RequestURL: String{
        case serverURL = "http://127.0.0.1:8080/api/board"
    }
    
    //MARK: - HTTP 메소드 요청
    static func request<T: Codable>(
        url: RequestURL = RequestURL.serverURL,
        endpoint: String,
        parameters: [String: String]? = nil,
        body: Codable? = nil,
        method: String = "GET"
    ) async throws -> T {
        let destination = try makeURL(url: url, endpoint: endpoint, parameters: parameters) // url 만들기
        return try await requestToServer(url: destination, method: method, body: body) // API 요청
    }
    
    //MARK: - URL 생성
    private static func makeURL(url: RequestURL,
                                endpoint: String,
                                parameters: [String: String]? = nil) throws -> URL {
        
        var urlString = url.rawValue + endpoint
        
        if let parameters = parameters {
            let queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            var components = URLComponents(string: urlString)!
            components.queryItems = queryItems
            urlString = components.url?.absoluteString ?? urlString
        }
        
        guard let url = URL(string: urlString) else {
            throw ErrorType.invalidURL
        }
        
        return url
    }
    
    //MARK: - 네트워크 요청 메서드
    private static func requestToServer<T: Codable>(
        url: URL,
        method: String = "GET",
        body: Codable? = nil) async throws -> T {
            
            var request = URLRequest(url: url)
            request.httpMethod = method
            
            // body가 있을 경우 JSON 형태로 인코딩해서 추가
            if let body = body {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                do {
                    request.httpBody = try JSONEncoder().encode(body)
                } catch {
                    print("Error encoding body: \(error)")
                    throw error
                }
            }
            
            // 네트워크 요청 실행
            let data: Data
            let response: URLResponse
            
            if method == "GET" {
                // GET 요청
                (data, response) = try await URLSession.shared.data(from: url)
            } else {
                // POST 요청 (또는 다른 HTTP 메서드)
                (data, response) = try await URLSession.shared.data(for: request)
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               let defindedErrorCode = NetworkErrorCode(rawValue: httpResponse.statusCode) {
                throw ErrorType.serverDefinedError(defindedErrorCode)
            }
            
            do {
                // 네트워크 요청 후 서버로부터 받은 데이터를 디코딩
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                return decodedResponse
            } catch {
                throw ErrorType.decodingFailure(underlying: error)
            }
            
        }
}

//MARK: - Error 처리
enum NetworkErrorCode: Int {
    case idNotFoundError = 301
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case internalServerError = 500
    case notImplement = 501
    case badGateway = 502
    case serviceUnavailable = 503
    
    var showErrorDescription: String {
        switch self {
        case .idNotFoundError:
            return "301: 요청한 ID를 찾을 수 없습니다."
        case .badRequest:
            return "400: 잘못된 요청입니다."
        case .unauthorized:
            return "401: 요청에 필요한 권한이 없습니다."
        case .forbidden:
            return "403: 접근이 금지되었습니다."
        case .notFound:
            return "404: 리소스를 찾을 수 없습니다."
        case .internalServerError:
            return "500: 서버에 에러가 발생하였습니다."
        case .notImplement:
            return "요청한 사항을 서버에서 실행할 수 없습니다."
        case .badGateway:
            return "게이트웨이 에러"
        case .serviceUnavailable:
            return "서버 점검 중"
        }
    }
}

enum ErrorType: Error {
    case invalidURL
    case networkFailure(underlying: Error)
    case invalidResponse(statusCode: Int)
    case decodingFailure(underlying: Error)
    case unknown(underlying: Error)
    case serverDefinedError(NetworkErrorCode)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .networkFailure(let err):
            return "A network error occurred: \(err.localizedDescription)"
        case .invalidResponse(let statusCode):
            return "Invalid response from server with status code \(statusCode)."
        case .decodingFailure:
            return "Failed to decode the response."
        case .unknown(let err):
            return "An unknown error occurred: \(err.localizedDescription)"
        case .serverDefinedError(let code):
            return code.showErrorDescription
        }
    }
}

