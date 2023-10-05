//
//  CatalogResultsView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//

import SwiftUI
import MiamIOSFramework

/// This sets the Templates for the PreferencesSearchView Overview
public class RecipesListParameters: RecipesListViewParameters {
    public var showRecipes: (MiamIOSFramework.CatalogPackage) -> Void
    public var noResultsRedirect: () -> Void
    public var onRecipeTapped: (String) -> Void
    public init(
        showRecipes: @escaping (MiamIOSFramework.CatalogPackage) -> Void,
        noResultsRedirect: @escaping () -> Void,
        onRecipeTapped: @escaping (String) -> Void
    ) {
        self.showRecipes = showRecipes
        self.noResultsRedirect = noResultsRedirect
        self.onRecipeTapped = onRecipeTapped
    }
}

struct CatalogResultsView: View {
    var MiamRecipesListViewConfig = RecipesListViewConfig(
        recipesListColumns: 2,
        recipesListSpacing: 8,
        recipeCardDimensions: CGSize(width: 300, height: 380),
        recipeCardFillMaxWidth: true
    )
    @Binding var navigationStack: [CatalogNavigationState]
    @Binding var selectedRecipe: String
    var body: some View {
        CatalogResultsViewTemplate(
            params: CatalogViewParams(
                filtersTapped: {
                    withAnimation {
                        navigationStack.append(.filters)
                    }
                },
                searchTapped: {
                    withAnimation {
                        navigationStack.append(.catalogSearch)
                    }
                },
                favoritesTapped: {
                    withAnimation {
                        navigationStack.append(.catalogResults)
                    }
                },
                preferencesTapped: {
                    withAnimation {
                        navigationStack.append(.preferences)
                    }
                },
                myMealsButtonTapped: {
                    print("myMealsButtonTapped")
                }),
            recipesListParams: RecipesListParameters(
            showRecipes: { catalog in
                print("show")
            }, noResultsRedirect: {
                withAnimation {
                    navigationStack.removeLast()
                    return
                }
            }, onRecipeTapped: { recipeId in
                selectedRecipe = recipeId
                withAnimation {
                    navigationStack.append(.recipeDetails)
                }
            }),
            config: MiamRecipesListViewConfig
        )
    }
}

struct CatalogResultsView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogResultsView(
            navigationStack: .constant([.catalog]),
            selectedRecipe: .constant("test")
        )
    }
}
