//  Created by Kristina Grebneva on 05.09.2025.


import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case httpStatus(Int, String)
    case missingAccessToken
    case decodingFailed
    case rpc(String)

    var detailedErrorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid CourtAI URL."
        case .httpStatus(let code, let body): return "Server error (\(code)): \(body)"
        case .missingAccessToken: return "Access token missing in response."
        case .decodingFailed: return "Failed to decode server response."
        case .rpc(let msg): return "Auth failed: \(msg)"
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .invalidURL, .httpStatus, .missingAccessToken, .decodingFailed, .rpc: return "Something went wrong. Please try again later."
        }
    }
}
