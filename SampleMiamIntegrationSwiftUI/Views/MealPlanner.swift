//
//  MealPlanner.swift
//  iosApp
//
//  Created by Vincent Kergonna on 07/06/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework
import miamCore

enum MealPlannerNavigationState {
    case form
    case mealPlanner
    case replaceRecipe
    case recipeDetails
    case basketPreview
    case itemSelector
    case recapRecipes
    case continueShopping
    case sponsorDetails
}

struct MealPlanner: View {
    @Binding var selectedView: String?
    @SwiftUI.State private var recipes: [String]?
    @SwiftUI.State private var navigationStack: [MealPlannerNavigationState] = []
    @SwiftUI.State private var selectedRecipe: String = ""
    @SwiftUI.State private var selectedSponsor: Sponsor? = nil
    
    struct PageWithHeader<Content: View>: View {
        private let view: Content
        @Binding var navigationStack: [MealPlannerNavigationState]
        init(navigationStack: Binding<[MealPlannerNavigationState]>, view: Content) {
            self.view = view
            _navigationStack = navigationStack
        }
        var body: some View {
            view
                .navigationBarItems(leading: Button(action: {
                    navigationStack.removeLast()
                }) {
                    Text("Back")
                }.foregroundColor(Color.white))
                .navigationBarTitleDisplayMode(.inline)
                .transition(.moveAndFade)
        }
    }
    
    var body: some View {
        NavigationView {
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
                        view: RecipeDetailsView(
                            popRecipeDetails: { withAnimation {
                                navigationStack.removeLast()
                                return
                            }},
                            launchSponsorDetails: { withAnimation {
                                navigationStack.append(.sponsorDetails)
                            }},
                            selectedRecipe: $selectedRecipe,
                            selectedSponsor: $selectedSponsor))
                case .sponsorDetails:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: SponsorDetailView(
                            selectedSponsor: $selectedSponsor))
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
                    MealPlannerFormPage(
                        navigationStack: $navigationStack,
                        recipes: $recipes)
                    .navigationBarItems(leading: Button(action: {
                        selectedView = nil
                    }) {
                        Text("Back")
                    }.foregroundColor(Color.white))
                    .transition(.moveAndFade)
                }
            }
        }
    }
}

struct MealPlanner_Previews: PreviewProvider {
    static var previews: some View {
        MealPlanner(selectedView: .constant(nil))
    }
}
