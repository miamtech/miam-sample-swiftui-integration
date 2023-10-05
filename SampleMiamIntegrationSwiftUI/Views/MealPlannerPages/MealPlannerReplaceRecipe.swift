//
//  MealPlannerReplaceRecipe.swift
//  iosApp
//
//  Created by didi on 23/08/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework

struct MealPlannerReplaceRecipe: View {
    @Binding var navigationStack: [MealPlannerNavigationState]
    @Binding var selectedRecipe: String
    var body: some View {
        MealPlannerRecipePickerView(
            searchTemplate: MiamBudgetSearch(),
            cardTemplate: MiamRecipeCard()) { _ in
                navigationStack.removeLast()
        } onRecipeTapped: {_ in
            navigationStack.append(.recipeDetails)
        }
    }
}

struct MealPlannerReplaceRecipe_Previews: PreviewProvider {
    static var previews: some View {
        MealPlannerReplaceRecipe(navigationStack: .constant([.mealPlanner]), selectedRecipe: .constant("id"))
    }
}
