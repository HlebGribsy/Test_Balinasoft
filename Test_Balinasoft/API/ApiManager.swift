//
//  ApiManager.swift
//  Test_Balinasoft
//
//  Created by Hleb Karpovich on 30.12.23.
//

import Foundation

struct PhotoType: Decodable {
    let content: [Content]
}

final class ApiManager {
    
    static let shared = ApiManager()
    
    func getPhotoType(numberOfPage: Int) async throws -> PhotoType {
        let url = URL(string: "https://junior.balinasoft.com/api/v2/photo/type?page=\(numberOfPage)")!
        let request = URLRequest(url: url)
        do {
            let responce = try await URLSession.shared.data(for: request)
            let photoType = try JSONDecoder().decode(PhotoType.self, from: responce.0)
            return photoType
        } catch {
            throw error
        }
    }
}
