//
//  MealPlannerReplaceRecipe.swift
//  iosApp
//
//  Created by didi on 23/08/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

struct MealPlannerReplaceRecipe: View {
    @Binding var navigationStack: [MealPlannerNavigationState]
    @Binding var selectedRecipe: String
    var body: some View {
        MealPlannerRecipePickerView(
            params:
                MealPlannerRecipePickerParameters(
                    onShowRecipeDetails: {_ in
                        navigationStack.append(.recipeDetails)
                    },
                    onSelectRecipeForMealPlanner: { _ in
                        navigationStack.removeLast()
                },
                    onOpenFiltersOptions: { _ in
//                        navigationStack.removeLast()
                }),
            gridConfig: localRecipesListViewConfig
        )
    }
}

struct MealPlannerReplaceRecipe_Previews: PreviewProvider {
    static var previews: some View {
        MealPlannerReplaceRecipe(navigationStack: .constant([.mealPlanner]), selectedRecipe: .constant("id"))
    }
}
