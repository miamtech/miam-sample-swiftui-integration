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
) ->  CatalogParameters {
    return CatalogParameters(
        onFiltersTapped: { withAnimation {
            selectedView.wrappedValue = "Filters"
        }},
        onSearchTapped: { withAnimation {
            selectedView.wrappedValue = "CatalogSearch"
        }},
        onFavoritesTapped: { withAnimation {
            selectedView.wrappedValue = "CatalogResults"
        }},
        onPreferencesTapped: { withAnimation {
            selectedView.wrappedValue = "Preferences"
        }},
        onLaunchMealPlanner: { withAnimation {
            selectedView.wrappedValue = "MealPlanner"
        }},
        onMyMealsButtonTapped: { withAnimation {
            tabViewModel.selectedTab = 1
        }},
        background: TypeSafeBackground(TestBackground()),
        loading: TypeSafeLoading(MyLoader())
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
            catalogPackageRowParams: CatalogPackageRowParameters(
                onSeeAllRecipes: { withAnimation {
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
