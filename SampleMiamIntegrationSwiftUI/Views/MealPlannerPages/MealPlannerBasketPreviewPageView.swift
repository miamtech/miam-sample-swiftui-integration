//
//  MealPlannerBasketPreviewPageView.swift
//  iosApp
//
//  Created by didi on 23/08/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework

struct MealPlannerBasketPreviewPageView: View {
    @Binding var navigationStack: [MealPlannerNavigationState]
    @Binding var selectedRecipe: String
    var body: some View {
        MealPlannerBasketPreviewView(
            loadingTemplate: MiamMealPlannerBasketPreviewLoading(),
            recipeOverviewTemplate: MiamMealPlannerBasketPreviewRecipeOverview(),
            recipeLoadingTemplate: MiamMealPlannerRecipeCardLoading(),
            productTemplate: MiamMealPlannerBasketPreviewProduct(),
            footerTemplate: MiamMealPlannerBasketPreviewFooter(),
            sectionTitleTemplate: MiamMealPlannerBasketPreviewSectionTitle(),
            sectionProductTemplate: MiamMealPlannerBasketPreviewSectionProduct()) {
                navigationStack.append(.itemSelector)
        } continueShopping: {
            navigationStack.append(.recapRecipes)
        } showBasket: {
//            navigationStack.append(.showBasket)
        } onRecipeTapped: { recipe in
            selectedRecipe = recipe
            navigationStack.append(.recipeDetails)
        }

    }
}

struct MealPlannerBasketPreviewPageView_Previews: PreviewProvider {
    static var previews: some View {
        MealPlannerBasketPreviewPageView(navigationStack: .constant([.mealPlanner]), selectedRecipe: .constant("id"))
    }
}
