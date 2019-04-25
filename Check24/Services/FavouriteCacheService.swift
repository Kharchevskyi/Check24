//
//  FavouriteCacheService.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import Foundation

final class FavouriteCacheService {
    private let userDefaults = UserDefaults.standard

    private let key = "products"

    func addToFavourite(with id: Int) {
        userDefaults.set(true, forKey: key+"id")
    }

    func removeFromFavourite(with id: Int) {
        userDefaults.removeObject(forKey: key+"id")
    }

    func isFavourite(with id: Int) -> Bool {
        return userDefaults.bool(forKey: key+"id")
    }
} 
