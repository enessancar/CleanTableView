//
//  PostModel.swift
//  CleanTableView
//
//  Created by Enes Sancar on 25.05.2023.
//

import Foundation

struct PostModel: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}
