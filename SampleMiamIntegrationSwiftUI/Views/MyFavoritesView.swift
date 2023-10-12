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
    //    binding bool to launch Acc settings determined by TabbedView
    @Binding var launchAccount: Bool
    //    decides if button is shown
    var showAccount: Bool
    @EnvironmentObject var tabViewModel: TabViewModel
    var body: some View {
        NavigationView {
            FavoritesViewTemplate(
                params: FavoritesParameters(
                    onNoResultsRedirect: {
                        tabViewModel.selectedTab = 3
                    },
                    onShowRecipeDetails: { recipeId in
                        print("launch recipeDetails")
                    }),
                gridConfig: localRecipesListViewConfig)
            .navigationTitle(LocalizedStringKey("tab_favorites")).navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    if showAccount { ShowAccountDependingOnStore(launchAccountSetting: $launchAccount)}
                })
        }
    }
}
