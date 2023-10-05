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

protocol NavigationState {
//    var isRecipeDetails: Bool { get }
}

enum CatalogNavigationState: NavigationState {
    case catalog
    case mealPlanner
    case preferences
    case preferencesSearch
    case catalogSearch
    case filters
    case catalogResults
    case recipeDetails
}

struct CatalogTabView: View {
    //    binding bool to launch Acc settings determined by TabbedView
    @Binding var launchAccount: Bool
    //    decides if button is shown
    var showAccount: Bool
    @SwiftUI.State private var selectedRecipe: String = ""
    
    @State private var navigationStack: [CatalogNavigationState] = []
    
    struct PageWithHeader<Content: View>: View {
        private let view: Content
        @Binding var navigationStack: [CatalogNavigationState]
        init(navigationStack: Binding<[CatalogNavigationState]>, view: Content) {
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
                case .catalog:
                    CatalogView(
                        navigationStack: $navigationStack,
                        selectedRecipe: $selectedRecipe)
                    .navigationBarBackButtonHidden(true)
                    .transition(.move(edge: .trailing))
                case .mealPlanner:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: MealPlanner(parentNavigationStack: $navigationStack))
                case .preferences:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: PreferencesView(navigationStack: $navigationStack))
                case .preferencesSearch:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: PreferencesSearchView(navigationStack: $navigationStack))
                case .catalogSearch:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: CatalogSearchView(navigationStack: $navigationStack))
                case .filters:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: FiltersView(navigationStack: $navigationStack))
                case .catalogResults:
                    PageWithHeader(
                        navigationStack: $navigationStack,
                        view: CatalogResultsView(
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
                default:
                    CatalogView(
                        navigationStack: $navigationStack,
                        selectedRecipe: $selectedRecipe)
                    .navigationBarBackButtonHidden(true)
                    .transition(.move(edge: .trailing))
                }
            }
            .navigationTitle(LocalizedStringKey("tab_catalog")).navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                if showAccount { ShowAccountDependingOnStore(launchAccountSetting: $launchAccount)}
            })
        }
    }
}
