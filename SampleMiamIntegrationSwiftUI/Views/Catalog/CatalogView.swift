//
//  CatalogView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

/// This sets the Templates for the CatalogPage Overview
public struct CatalogViewParams: CatalogViewParameters {
    public var filtersTapped: () -> Void
    public var searchTapped: () -> Void
    public var favoritesTapped: () -> Void
    public var preferencesTapped: () -> Void
    public var launchMealPlanner: (() -> Void)?
    public var myMealsButtonTapped: () -> Void
    public init(
        filtersTapped: @escaping () -> Void,
        searchTapped: @escaping () -> Void,
        favoritesTapped: @escaping () -> Void,
        preferencesTapped: @escaping () -> Void,
        launchMealPlanner: (() -> Void)?,
        myMealsButtonTapped: @escaping () -> Void
    ) {
        self.filtersTapped = filtersTapped
        self.searchTapped = searchTapped
        self.favoritesTapped = favoritesTapped
        self.preferencesTapped = preferencesTapped
        self.launchMealPlanner = launchMealPlanner
        self.myMealsButtonTapped = myMealsButtonTapped
    }
    
    // if you WANT the meal Planner:
    public var mealPlannerCTA = MiamNeutralMealPlannerCallToAction() // your CTA
}

/// This sets the Templates for the CatalogRecipesList Overview
public class MiamNeutralCatalogPackageRowParams: CatalogPackageRowParameters {
    public var showRecipes: () -> Void
    public var onRecipeTapped: (String) -> Void
    public init(
        showRecipes: @escaping () -> Void,
        onRecipeTapped: @escaping (String) -> Void
    ) {
        self.showRecipes = showRecipes
        self.onRecipeTapped = onRecipeTapped
    }
}

struct CatalogView: View {
    @Binding var navigationStack: [CatalogNavigationState]
    var MiamRecipesListViewConfig = RecipesListViewConfig(
        recipesListColumns: 2,
        recipesListSpacing: 8,
        recipeCardDimensions: CGSize(width: 300, height: 380),
        recipeCardFillMaxWidth: true
    )
    
    var body: some View {
        CatalogViewTemplate(
            params: CatalogViewParams(
                filtersTapped: {
                    navigationStack.append(.filters)
                },
                searchTapped: {
                    navigationStack.append(.catalogSearch)
                },
                favoritesTapped: {
                    navigationStack.append(.catalogResults)
                },
                preferencesTapped: {
                    navigationStack.append(.preferences)
                },
                launchMealPlanner: {
                    navigationStack.append(.mealPlanner)
                },
                myMealsButtonTapped: {
//                    print("myMealsButtonTapped")
                }),
            catalogPackageRowParams: MiamNeutralCatalogPackageRowParams(
                showRecipes: {
                    navigationStack.append(.catalogResults)
                },
                onRecipeTapped: { recipeId in
                    print("onRecipeTapped")
                }),
            config: MiamRecipesListViewConfig)
    }
}
