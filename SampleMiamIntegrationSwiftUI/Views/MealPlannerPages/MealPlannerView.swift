//
//  MealPlannerView.swift
//  iosApp
//
//  Created by didi on 23/08/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

struct MealPlannerView: View {
    @Binding var navigationStack: [MealPlannerNavigationState]
    var body: some View {
        MealPlannerResultsViewTemplate(
            params:
                MealPlannerResultsParameters(
                    onShowRecipeDetails: { _ in
                        navigationStack.append(.recipeDetails)
                    },
                    onOpenReplaceRecipe: { _ in
                        navigationStack.append(.replaceRecipe)
                    },
                    onNavigateToBasket: {
                        navigationStack.append(.basketPreview)
                    }),
            gridConfig: MealPlannerRecipesListGridConfig(
                horizontalSpacing: 6,
                verticalSpacing: 6, 
                recipeCardDimensions: CGSize(width: 300, height: 300)))
        
    }
}

struct MealPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        MealPlannerView(navigationStack: .constant([.mealPlanner]))
    }
}
