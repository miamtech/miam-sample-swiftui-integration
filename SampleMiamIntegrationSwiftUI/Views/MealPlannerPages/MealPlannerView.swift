//
//  MealPlannerView.swift
//  iosApp
//
//  Created by didi on 23/08/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework

struct MealPlannerView: View {
    @Binding var navigationStack: [MealPlannerNavigationState]
    var body: some View {
        MealPlannerPlannerView(
            toolbarTemplate: MiamBudgetPlannerToolbar(),
            footerTemplate: MiamBudgetPlannerStickyFooter(),
            loadingTemplate: MiamBudgetPlannerLoading(),
            emptyTemplate: MiamBudgetPlannerEmpty(),
            recipeCardTemplate: MiamMealPlannerRecipeCard(),
            loadingCardTemplate: MiamMealPlannerRecipeCardLoading(),
            placeholderCardTemplate: MiamMealPlannerRecipePlaceholder()
        ) { _ in
            navigationStack.append(.recipeDetails)
        } validateRecipes: {
            navigationStack.append(.basketPreview)
        } replaceRecipe: { _ in
            navigationStack.append(.replaceRecipe)
        }
    }
}

struct MealPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        MealPlannerView(navigationStack: .constant([.mealPlanner]))
    }
}
