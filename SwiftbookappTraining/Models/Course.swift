//
//  Course.swift
//  SwiftbookappTraining
//
//  Created by Дмитрий Дмитрий on 15.02.2023.
//

import Foundation

struct Course: Decodable {
    let name: String
    let imageUrl: URL?
    let numberOfLessons: Int
    let numberOfTests: Int
}
