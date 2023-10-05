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
}

struct MealPlanner: View {
    @Binding var parentNavigationStack: [CatalogNavigationState]
    @SwiftUI.State private var recipes: [String]?
    @State private var navigationStack: [MealPlannerNavigationState] = []
    @SwiftUI.State private var selectedRecipe: String = ""
    
    struct PageWithHeader<Content: View>: View {
        private let view: Content
        @Binding var navigationStack: [MealPlannerNavigationState]
        init(navigationStack: Binding<[MealPlannerNavigationState]>, view: Content) {
            self.view = view
            _navigationStack = navigationStack
        }
        var body: some View {
            view
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button("Back") {
                    navigationStack.removeLast()
                })
                .transition(.moveAndFade)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                switch navigationStack.last {
                case .mealPlanner:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: MealPlannerView(navigationStack: $navigationStack))
                case .replaceRecipe:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: MealPlannerReplaceRecipe(
                            navigationStack: $navigationStack,
                            selectedRecipe: $selectedRecipe))
                case .recipeDetails:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: RecipeDetailsPageView(
                            popRecipeDetails: { withAnimation {
                                navigationStack.removeLast()
                                return
                            }},
                            selectedRecipe: $selectedRecipe))
                case .basketPreview:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: MealPlannerBasketPreviewPageView(
                            navigationStack: $navigationStack,
                            selectedRecipe: $selectedRecipe))
                case .itemSelector:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: ItemSelectorPageView(
                            navigationStack: $navigationStack,
                            selectedRecipe: $selectedRecipe))
                case .recapRecipes:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: MealPlannerRecapPageView())
                default:
                    MealPlannerFormPage(navigationStack: $navigationStack, recipes: $recipes)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button("Back") {
                            parentNavigationStack.removeLast()
                        })
                        .transition(.moveAndFade)
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
