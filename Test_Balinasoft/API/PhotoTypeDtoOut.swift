//
//  PhotoTypeDtoOut.swift
//  Test_Balinasoft
//
//  Created by Hleb Karpovich on 30.12.23.
//

import Foundation

struct PhotoTypeDtoOut: Codable {
    let content: [Content]
    let page: Int
    let pageSize: Int
    let totalElements: Int
    let totalPages: Int
}

struct Content: Codable {
    let id: Int
    let name: String
    let image: String?
}
