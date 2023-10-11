//
//  ItemSelectorPageView.swift
//  iosApp
//
//  Created by didi on 23/08/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

struct ItemSelectorPageView: View {
    @Binding var navigationStack: [MealPlannerNavigationState]
    @Binding var selectedRecipe: String
    var body: some View {
        ItemSelector(
            params: ItemSelectorParameters(onItemSelected: {navigationStack.removeLast()}),
            recipeId: selectedRecipe
        )
    }
}

struct ItemSelectorPageView_Previews: PreviewProvider {
    static var previews: some View {
        ItemSelectorPageView(navigationStack: .constant([.mealPlanner]), selectedRecipe: .constant("id"))
    }
}
