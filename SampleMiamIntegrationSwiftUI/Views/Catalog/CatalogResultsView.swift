//
//  CatalogResultsView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

struct CatalogResultsView: View {
    var MiamRecipesListViewConfig = RecipesListViewConfig(
        recipesListColumns: 2,
        recipesListSpacing: 8,
        recipeCardDimensions: CGSize(width: 300, height: 380),
        recipeCardFillMaxWidth: true
    )
    @EnvironmentObject var tabViewModel: TabViewModel
    @Binding var selectedView: String?
    @Binding var selectedRecipe: String
    var body: some View {
        CatalogResultsViewTemplate(
            params: sharedCatalogNavigation(
                selectedView: $selectedView,
                tabViewModel: tabViewModel),
            recipesListParams: DefaultRecipesListParams(
                showRecipes: { catalog in
                    print("show")
                }, noResultsRedirect: {
                    withAnimation {
                        selectedView = nil
                        return
                    }
                }, onRecipeTapped: { recipeId in
                    selectedRecipe = recipeId
                    withAnimation {
                        selectedView = "RecipeDetails"
                    }
                }),
            config: MiamRecipesListViewConfig
        )
    }
}

struct CatalogResultsView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogResultsView(
            selectedView: .constant(nil),
            selectedRecipe: .constant("test")
        )
    }
}
