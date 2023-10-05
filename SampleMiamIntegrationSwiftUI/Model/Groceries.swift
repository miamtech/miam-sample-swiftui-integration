//
//  Groceries.swift
//  iosApp
//
//  Created by Vincent Kergonna on 19/07/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
import miamCore
import Combine

class Groceries: ObservableObject {
    @Published var numberOfRecipes: Int = 0
    let groceriesHandler = GroceriesListHandler.shared

    init() {
        groceriesHandler.onRecipeCountChange { [weak self] count in
                    DispatchQueue.main.async {
                        self?.numberOfRecipes = Int(truncating: count)
                    }
                }
    }

    func refreshRecipeCount() {
        groceriesHandler.onRecipeCountChange { count in
            self.numberOfRecipes = Int(truncating: count)
        }
    }

    func reset() {
        GroceriesListHandler.shared.resetGroceriesList()
    }
}
