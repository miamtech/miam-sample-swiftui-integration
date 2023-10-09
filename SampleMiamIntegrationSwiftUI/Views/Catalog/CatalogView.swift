//
//  CatalogView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework



public func sharedCatalogNavigation(
    selectedView: Binding<String?>,
    tabViewModel: TabViewModel
) ->  CatalogViewParamsWithMealPlanner {
    return CatalogViewParamsWithMealPlanner(
        filtersTapped: { withAnimation {
            selectedView.wrappedValue = "Filters"
        }},
        searchTapped: { withAnimation {
            selectedView.wrappedValue = "CatalogSearch"
        }},
        favoritesTapped: { withAnimation {
            selectedView.wrappedValue = "CatalogResults"
        }},
        preferencesTapped: { withAnimation {
            selectedView.wrappedValue = "Preferences"
        }},
        launchMealPlanner: { withAnimation {
            selectedView.wrappedValue = "MealPlanner"
        }},
        myMealsButtonTapped: { withAnimation {
            tabViewModel.selectedTab = 1
        }},
        customBackground: TypeSafeBackground(TestBackground()),
        customLoading: TypeSafeLoading(MyLoader())
    )
}

public class MyLoader: LoadingProtocol {
    public func content() -> some View {
        Text("i am loading slow!")
    }
}


struct CatalogView: View {
    @Binding var selectedRecipe: String
    @Binding var selectedView: String?
    @EnvironmentObject var tabViewModel: TabViewModel
    var MiamRecipesListViewConfig = RecipesListViewConfig(
        recipesListColumns: 2,
        recipesListSpacing: 8,
        recipeCardDimensions: CGSize(width: 300, height: 380),
        recipeCardFillMaxWidth: true
    )
    
    var body: some View {
        CatalogViewTemplate(
            params: sharedCatalogNavigation(
                selectedView: $selectedView,
                tabViewModel: tabViewModel),
            catalogPackageRowParams: DefaultCatalogPackageRowParams(
                showRecipes: { withAnimation {
                    selectedView = "CatalogResults"
                }},
                onRecipeTapped: { recipeId in
                    withAnimation {
                        selectedRecipe = recipeId
                        selectedView = "RecipeDetails"
                    }
                }),
            config: MiamRecipesListViewConfig)
    }
}
