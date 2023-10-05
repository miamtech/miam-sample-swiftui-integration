//
//  RecipeDetailsView.swift
//  iosApp
//
//  Created by didi on 23/08/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework

struct RecipeDetailsPageView: View {
    @Binding var navigationStack: [MealPlannerNavigationState]
    @Binding var selectedRecipe: String
    var body: some View {
        // TODO: on 3.13 -> move this to MiamN templating
        Text("recipe details")
    }
}

struct RecipeDetailsPageView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsPageView(navigationStack: .constant([.mealPlanner]), selectedRecipe: .constant("id"))
    }
}
