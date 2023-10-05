//
//  JSONHelpers.swift
//  iosApp
//
//  Created by didi on 4/17/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import Foundation

func loadObject<T: Decodable>(from url: URL, as objectType: T.Type) -> T? {
    do {
        let data = try Data(contentsOf: url)
        let object = try JSONDecoder().decode(objectType, from: data)
        return object
    } catch {
        print("Error loading object from URL: \(url.absoluteString). Error: \(error)")
        return nil
    }
}
