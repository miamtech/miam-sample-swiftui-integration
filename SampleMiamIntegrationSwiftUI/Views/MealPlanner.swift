//
//  MealPlanner.swift
//  iosApp
//
//  Created by Vincent Kergonna on 07/06/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework

enum MealPlannerNavigationState {
    case form
    case mealPlanner
    case replaceRecipe
    case recipeDetails
    case basketPreview
    case itemSelector
    case recapRecipes
    case continueShopping
    // ... add other states as needed
}

struct MealPlanner: View {
    @Binding var showMealPlanner: Bool

    @SwiftUI.State private var recipes: [String]?
    @State private var navigationStack: [MealPlannerNavigationState] = []
    @SwiftUI.State private var selectedRecipe: String = ""
    var body: some View {
        VStack {
            switch navigationStack.last {
            case .mealPlanner:
                NavigationLink(
                    destination:
                        MealPlannerView(navigationStack: $navigationStack)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button("Back") {
                            navigationStack.removeLast()
                    }), isActive: .constant(true)) {
                    EmptyView()
                }
            case .replaceRecipe:
                NavigationLink(
                    destination:
                        MealPlannerReplaceRecipe(navigationStack: $navigationStack, selectedRecipe: $selectedRecipe)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button("Back") {
                            navigationStack.removeLast()
                    }), isActive: .constant(true)) {
                    EmptyView()
                }
            case .recipeDetails:
                NavigationLink(
                    destination: RecipeDetailsPageView(navigationStack: $navigationStack, selectedRecipe: $selectedRecipe)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button("Back") {
                            navigationStack.removeLast()
                    }), isActive: .constant(true)) {
                    EmptyView()
                }
            case .basketPreview:
                NavigationLink(
                    destination: MealPlannerBasketPreviewPageView(navigationStack: $navigationStack, selectedRecipe: $selectedRecipe)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button("Back") {
                            navigationStack.removeLast()
                    }), isActive: .constant(true)) {
                    EmptyView()
                }
            case .itemSelector:
                NavigationLink(
                    destination:
                        ItemSelectorPageView(navigationStack: $navigationStack, selectedRecipe: $selectedRecipe)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button("Back") {
                            navigationStack.removeLast()
                    }), isActive: .constant(true)) {
                    EmptyView()
                }
            case .recapRecipes:
                NavigationLink(
                    destination:
                        MealPlannerRecapPageView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button("Back") {
                            navigationStack.removeLast()
                    }), isActive: .constant(true)) {
                    EmptyView()
                }
            default:
                NavigationLink(
                    destination:
                        MealPlannerFormPage(navigationStack: $navigationStack, recipes: $recipes)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button("Back") {
                            showMealPlanner = false
                    }), isActive: .constant(true)) {
                    EmptyView()
                }
            }
        }
    }
}

struct MealPlanner_Previews: PreviewProvider {
    static var previews: some View {
        MealPlanner(showMealPlanner: .constant(false))
    }
}
