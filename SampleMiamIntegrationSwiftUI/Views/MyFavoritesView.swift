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

public struct TestRecipeCard: CatalogRecipeCardProtocol {
    public func content(recipeCardDimensions: CGSize, recipeInfos: RecipeInfos, actions: RecipeCardActions) -> some View {
        Circle()
            .foregroundColor(.red)
            .frame(width: recipeCardDimensions.width, height: recipeCardDimensions.height)
    }
}
public struct TestBackground: BackgroundProtocol {
    public func content() -> some View {
        Color.red
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
    @EnvironmentObject var tabViewModel: TabViewModel
    var body: some View {
        NavigationView {
            FavoritesViewTemplate(
                params: DefaultFavoritesParams(
                    showRecipes: { catalog in
                        print("launch catalog")
                    },
                    noResultsRedirect: {
                        tabViewModel.selectedTab = 3
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
