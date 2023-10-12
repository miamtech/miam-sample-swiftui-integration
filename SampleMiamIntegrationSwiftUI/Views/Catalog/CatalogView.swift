//
//  CatalogView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework
import miamCore

public func sharedCatalogNavigation(
    selectedView: Binding<String?>,
    selectedFilterViewModel: Binding<SingletonFilterViewModel>,
    tabViewModel: TabViewModel
) ->  CatalogParameters {
    return CatalogParameters(
        onFiltersTapped: { singletonFilter in withAnimation {
            selectedFilterViewModel.wrappedValue = singletonFilter
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
        onMealsInBasketButtonTapped: { withAnimation {
            tabViewModel.selectedTab = 1
        }},
        viewOptions: CatalogParamsViewOptions(
            loading: TypeSafeLoading(MyLoader()),
            background: TypeSafeBackground(TestBackground())
        )
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
    @Binding var selectedFilterViewModel: SingletonFilterViewModel
    @EnvironmentObject var tabViewModel: TabViewModel
    
    var body: some View {
        CatalogViewTemplate(
            params: sharedCatalogNavigation(
                selectedView: $selectedView,
                selectedFilterViewModel: $selectedFilterViewModel,
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
            gridConfig: localRecipesListViewConfig)
    }
}
