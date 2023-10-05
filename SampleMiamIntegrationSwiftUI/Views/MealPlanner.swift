//
//  MealPlanner.swift
//  iosApp
//
//  Created by Vincent Kergonna on 07/06/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework

enum MealPlannerNavigationState: NavigationState {
    case form
    case mealPlanner
    case replaceRecipe
    case recipeDetails
    case basketPreview
    case itemSelector
    case recapRecipes
    case continueShopping
}

struct MealPlanner: View {
    @Binding var parentNavigationStack: [CatalogNavigationState]
    @SwiftUI.State private var recipes: [String]?
    @State private var navigationStack: [MealPlannerNavigationState] = []
    @SwiftUI.State private var selectedRecipe: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                switch navigationStack.last {
                case .mealPlanner:
                    MealPlannerView(navigationStack: $navigationStack)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button("Back") {
                            navigationStack.removeLast()
                        })
                case .replaceRecipe:
                    MealPlannerReplaceRecipe(navigationStack: $navigationStack, selectedRecipe: $selectedRecipe)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button("Back") {
                            navigationStack.removeLast()
                        })
                case .recipeDetails:
                    RecipeDetailsPageView(
                        popRecipeDetails: {  navigationStack.removeLast() },
                        selectedRecipe: $selectedRecipe)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: Button("Back") {
                        navigationStack.removeLast()
                    })
                case .basketPreview: MealPlannerBasketPreviewPageView(navigationStack: $navigationStack, selectedRecipe: $selectedRecipe)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button("Back") {
                            navigationStack.removeLast()
                        })
                case .itemSelector:
                    ItemSelectorPageView(navigationStack: $navigationStack, selectedRecipe: $selectedRecipe)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button("Back") {
                            navigationStack.removeLast()
                        })
                case .recapRecipes:
                    MealPlannerRecapPageView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button("Back") {
                            navigationStack.removeLast()
                        })
                default:
                    MealPlannerFormPage(navigationStack: $navigationStack, recipes: $recipes)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button("Back") {
                            parentNavigationStack.removeLast()
                        })
                }
            }
        }
    }
}

struct MealPlanner_Previews: PreviewProvider {
    static var previews: some View {
        MealPlanner(parentNavigationStack: .constant([]))
    }
}
