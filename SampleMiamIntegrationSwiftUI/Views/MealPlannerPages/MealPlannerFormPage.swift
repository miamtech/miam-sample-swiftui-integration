//
//  MealPlannerFormPage.swift
//  iosApp
//
//  Created by didi on 23/08/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

struct MealPlannerFormPage: View {
    @Binding var navigationStack: [MealPlannerNavigationState]
    @Binding var recipes: [String]?
    var body: some View {
        MealPlannerFormPageViewTemplate(
            params: MealPlannerFormParameters(
                onNavigateToMealPlannerResults: { recipes in
                    self.recipes = recipes
                    withAnimation { navigationStack.append(.mealPlanner) }
                }))
    }
}

struct MealPlannerFormPage_Previews: PreviewProvider {
    static var previews: some View {
        MealPlannerFormPage(navigationStack: .constant([.mealPlanner]), recipes: .constant([]))
    }
}
