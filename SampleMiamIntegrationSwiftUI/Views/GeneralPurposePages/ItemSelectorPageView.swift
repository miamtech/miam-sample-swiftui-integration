//
//  ItemSelectorPageView.swift
//  iosApp
//
//  Created by didi on 23/08/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework

struct ItemSelectorPageView: View {
    @Binding var navigationStack: [MealPlannerNavigationState]
    @Binding var selectedRecipe: String
    var body: some View {
        ItemSelector(recipeId: selectedRecipe, onItemSelected: {
                navigationStack.removeLast()
            })
    }
}

struct ItemSelectorPageView_Previews: PreviewProvider {
    static var previews: some View {
        ItemSelectorPageView(navigationStack: .constant([.mealPlanner]), selectedRecipe: .constant("id"))
    }
}
