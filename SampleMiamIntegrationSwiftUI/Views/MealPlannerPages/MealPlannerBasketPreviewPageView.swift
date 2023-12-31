//
//  MealPlannerBasketPreviewPageView.swift
//  iosApp
//
//  Created by didi on 23/08/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

struct MealPlannerBasketPreviewPageView: View {
    @Binding var navigationStack: [MealPlannerNavigationState]
    @Binding var selectedRecipe: String
    var body: some View {
        MealPlannerBasketView(
            params: MealPlannerBasketParameters(
                onNavigateToRecap: {
                    navigationStack.append(.recapRecipes)
                },
                onNavigateToBasket: {
                    navigationStack.append(.recapRecipes)
                }),
            basketRecipesParams: BasketRecipeParameters(
                onReplaceRecipe: {
                    navigationStack.append(.itemSelector)
                },
                onShowRecipeDetails: { recipe in
                    selectedRecipe = recipe
                    navigationStack.append(.recipeDetails)
                }),
            gridConfig: BasketRecipesGridConfig(
                recipeHorizontalSpacing: 6.0,
                recipeVerticalSpacing: 6.0,
                productHorizontalSpacing: 6.0,
                productVerticalSpacing: 6.0,
                recipeOverviewDimensions: CGSize(width: 300, height: 150),
                isExpandable: true)
        )
    }
}

struct MealPlannerBasketPreviewPageView_Previews: PreviewProvider {
    static var previews: some View {
        MealPlannerBasketPreviewPageView(navigationStack: .constant([.mealPlanner]), selectedRecipe: .constant("id"))
    }
}
