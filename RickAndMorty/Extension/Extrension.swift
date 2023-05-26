//
//  Extrension.swift
//  RickAndMorty
//
//  Created by Enes Sancar on 26.05.2023.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
