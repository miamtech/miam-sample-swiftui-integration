//
//  MyFavoritesView.swift
//  iosApp
//
//  Created by Vincent Kergonna on 23/09/2022.
//  Copyright © 2022 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

/// This sets the Templates for the Favorites Overview
public class MiamNeutralFavoritesParams: FavoritesViewParameters {
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

struct MyFavoritesView: View {
    var FavoritesPageRecipesListViewConfig = RecipesListViewConfig(
        recipesListColumns: 2,
        recipesListSpacing: 8,
        recipeCardDimensions: CGSize(width: 300, height: 380),
        recipeCardFillMaxWidth: true
    )
    //    binding bool to launch Acc settings determined by TabbedView
    @Binding var launchAccount: Bool
    //    decides if button is shown
    var showAccount: Bool
    var body: some View {
        NavigationView {
            FavoritesViewTemplate(
                params: MiamNeutralFavoritesParams(
                    showRecipes: { catalog in
                        print("launch catalog")
                    },
                    noResultsRedirect: {
                        print("redirect to catalog")
                    },
                    onRecipeTapped: { recipeId in
                        print("launch recipeDetails")
                    }),
                config: FavoritesPageRecipesListViewConfig)
            .navigationTitle(LocalizedStringKey("tab_favorites")).navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    if showAccount { ShowAccountDependingOnStore(launchAccountSetting: $launchAccount)}
                })
        }
    }
}
