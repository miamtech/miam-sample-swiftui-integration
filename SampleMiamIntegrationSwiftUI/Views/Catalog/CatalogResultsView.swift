//
//  CatalogResultsView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework
import miamCore

public var localRecipesListViewConfig = RecipesListGridConfig(
    columns: 2,
    horizontalSpacing: 6,
    verticalSpacing: 6,
    recipeCardDimensions: CGSize(width: 300, height: 380),
    recipeCardFillMaxWidth: true)


struct CatalogResultsView: View {
    
    @EnvironmentObject var tabViewModel: TabViewModel
    @Binding var selectedView: String?
    @Binding var selectedRecipe: String
    @Binding var selectedFilterViewModel: SingletonFilterViewModel
    var body: some View {
        CatalogResultsViewTemplate(
            params: sharedCatalogNavigation(
                selectedView: $selectedView,
                selectedFilterViewModel: $selectedFilterViewModel,
                tabViewModel: tabViewModel),
            recipesListParams: RecipesListParameters(
                onShowRecipes: { catalog in
                    print("show")
                }, onNoResultsRedirect: {
                    withAnimation {
                        selectedView = nil
                        return
                    }
                }, onShowRecipeDetails: { recipeId in
                    selectedRecipe = recipeId
                    withAnimation {
                        selectedView = "RecipeDetails"
                    }
                }),
            gridConfig: localRecipesListViewConfig
        )
    }
}

struct CatalogResultsView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogResultsView(
            selectedView: .constant(nil),
            selectedRecipe: .constant("test"),
            selectedFilterViewModel: .constant(MiamDI.shared.recipeFilterViewModel)
        )
    }
}
