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


enum CatalogNavigationState {
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

    var body: some View {
        NavigationView {
            VStack {
                switch navigationStack.last {
                case .catalog:
                    NavigationLink(
                        destination:
                            CatalogView(
                                navigationStack: $navigationStack)
                            .navigationBarBackButtonHidden(true)
                        ) {
                        EmptyView()
                    }
//                case .mealPlanner:
//                    NavigationLink(
//                        destination:
//                            MealPlanner(navigationStack: $navigationStack)
//                            .navigationBarBackButtonHidden(true)
//                            .navigationBarItems(leading: Button("Back") {
//                                navigationStack.removeLast()
//                        }), isActive: .constant(true)) {
//                        EmptyView()
//                    }
                case .preferences:
                    NavigationLink(
                        destination: PreferencesView(navigationStack: $navigationStack)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarItems(leading: Button("Back") {
                                navigationStack.removeLast()
                        }), isActive: .constant(true)) {
                        EmptyView()
                    }
                case .preferencesSearch:
                    NavigationLink(
                        destination: PreferencesSearchView(navigationStack: $navigationStack)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarItems(leading: Button("Back") {
                                navigationStack.removeLast()
                        }), isActive: .constant(true)) {
                        EmptyView()
                    }
                case .catalogSearch:
                    NavigationLink(
                        destination:
                            CatalogSearchView(navigationStack: $navigationStack)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarItems(leading: Button("Back") {
                                navigationStack.removeLast()
                        }), isActive: .constant(true)) {
                        EmptyView()
                    }
                case .filters:
                    NavigationLink(
                        destination:
                            FiltersView(navigationStack: $navigationStack)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarItems(leading: Button("Back") {
                                navigationStack.removeLast()
                        }), isActive: .constant(true)) {
                        EmptyView()
                    }
                case .catalogResults:
                    NavigationLink(
                        destination:
                            CatalogResultsView(navigationStack: $navigationStack)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarItems(leading: Button("Back") {
                                navigationStack.removeLast()
                        }), isActive: .constant(true)) {
                        EmptyView()
                    }
//                case .recipeDetails:
//                    NavigationLink(
//                        destination: RecipeDetailsPageView(navigationStack: $navigationStack, selectedRecipe: $selectedRecipe)
//                            .navigationBarBackButtonHidden(true)
//                            .navigationBarItems(leading: Button("Back") {
//                                navigationStack.removeLast()
//                        }), isActive: .constant(true)) {
//                        EmptyView()
//                    }
                default:
                    NavigationLink(
                        destination:
                            CatalogView(navigationStack: $navigationStack)
                            .navigationBarBackButtonHidden(true)
                    ) {
                        CatalogView(navigationStack: $navigationStack)
                    }
                }
            }
            .navigationTitle(LocalizedStringKey("tab_catalog")).navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                if showAccount { ShowAccountDependingOnStore(launchAccountSetting: $launchAccount)}
            })
        }
    }
}
