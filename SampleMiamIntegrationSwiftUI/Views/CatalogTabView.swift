//
//  catalogTabView.swift
//  iosApp
//
//  Created by Miam on 27/07/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework
import miamCore

enum CatalogNavigationState  {
    case catalog
    case mealPlanner
    case preferences
    case preferencesSearch
    case catalogSearch
    case filters
    case catalogResults
    case recipeDetails
    case sponsorDetails
}

struct CatalogTabView: View {
    // binding bool to launch Acc settings determined by TabbedView
    @Binding var launchAccount: Bool
    // decides if button is shown
    var showAccount: Bool
    @SwiftUI.State private var selectedRecipe: String = ""
    @SwiftUI.State private var selectedSponsor: Sponsor? = nil
    
    @SwiftUI.State private var navigationStack: [CatalogNavigationState] = []
    
    struct PageWithHeader<Content: View>: View {
        private let view: Content
        @Binding var navigationStack: [CatalogNavigationState]
        init(navigationStack: Binding<[CatalogNavigationState]>, view: Content) {
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
                    MealPlanner(parentNavigationStack: $navigationStack)
                        .transition(.moveAndFade)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Meal Planner")
                case .preferences:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: PreferencesView(navigationStack: $navigationStack))
                    .navigationTitle("Preferences")
                case .preferencesSearch:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: PreferencesSearchView(navigationStack: $navigationStack))
                    .navigationTitle("Preferences Search")
                case .catalogSearch:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: CatalogSearchView(navigationStack: $navigationStack))
                    .navigationTitle("Search")
                case .filters:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: FiltersView(navigationStack: $navigationStack))
                    .navigationTitle("Filters")
                case .catalogResults:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: CatalogResultsView(
                            navigationStack: $navigationStack,
                            selectedRecipe: $selectedRecipe))
                    .navigationTitle("Results")
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
                    .navigationTitle("Recipe Details")
                case .sponsorDetails:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: SponsorDetailView(
                            selectedSponsor: $selectedSponsor))
                    .navigationTitle("Recipe Details")
                default:
                    CatalogView(
                        navigationStack: $navigationStack,
                        selectedRecipe: $selectedRecipe)
                    .navigationTitle(LocalizedStringKey("tab_catalog"))
                    .navigationBarTitleDisplayMode(.inline)
                    .transition(.moveAndFade)
                }
            }
        }
    }
}
