//
//  ApiManager.swift
//  Test_Balinasoft
//
//  Created by Hleb Karpovich on 30.12.23.
//

import Foundation
import Multipart

struct PhotoType: Decodable {
    let content: [Content]
}

struct API {
    static let baseURL: String = "https://junior.balinasoft.com"
}

final class ApiManager {
    
    static let shared = ApiManager()
    
    func getPhotoType(numberOfPage: Int) async throws -> PhotoType {
        let url = URL(string: API.baseURL + "/api/v2/photo/type?page=\(numberOfPage)")!
        let request = URLRequest(url: url)
        do {
            let response = try await URLSession.shared.data(for: request)
            let photoType = try JSONDecoder().decode(PhotoType.self, from: response.0)
            return photoType
        } catch {
            throw error
        }
    }
    
    func postPhotoType(name: String, photo: Data, typeId: String) {
        var message = Multipart(type: .formData)
        message.append(Part.FormData(name: "name", value: name))
        message.append(Part.FormData(name: "photo", fileData: photo, fileName: "image.jpeg", contentType: "image/jpeg"))
        message.append(Part.FormData(name: "typeId", value: typeId))
        
        var request = URLRequest(url: URL(string: API.baseURL + "/api/v2/photo")!)
        request.httpMethod = "POST"
        request.setMultipartBody(message)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(String(decoding: data, as: UTF8.self))
            }
        }.resume()
    }
    
}
