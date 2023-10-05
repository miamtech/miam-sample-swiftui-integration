//
//  catalogTabView.swift
//  iosApp
//
//  Created by Miam on 27/07/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

/// This sets the Templates for the CatalogPage Overview
public struct MiamNeutralCatalogViewParams: CatalogViewParameters {
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

struct CatalogTabView: View {
    //    binding bool to launch Acc settings determined by TabbedView
    @Binding var launchAccount: Bool
    //    decides if button is shown
    var showAccount: Bool
    // for setting mealPlanner
    @SwiftUI.State private var showMealPlanner: Bool = false
    var MiamRecipesListViewConfig = RecipesListViewConfig(
        recipesListColumns: 2,
        recipesListSpacing: 8,
        recipeCardDimensions: CGSize(width: 300, height: 380),
        recipeCardFillMaxWidth: true
    )
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                NavigationLink(
                    destination: MealPlanner(showMealPlanner: $showMealPlanner),
                    isActive: $showMealPlanner) { EmptyView().onAppear {
                        print("MealPlanner: on catalog")
                     } }
            CatalogViewTemplate(
                params: MiamNeutralCatalogViewParams(
                    filtersTapped: {
                        print("filtersTapped")
                    },
                    searchTapped: {
                        print("searchTapped")
                    },
                    favoritesTapped: {
                        print("favoritesTapped")
                    },
                    preferencesTapped: {
                        print("preferencesTapped")
                    },
                    launchMealPlanner: {
                        showMealPlanner = true
                    },
                    myMealsButtonTapped: {
                        print("myMealsButtonTapped")
                    }),
                catalogPackageRowParams: MiamNeutralCatalogPackageRowParams(
                    showRecipes: {
                        print("showRecipes")
                    },
                    onRecipeTapped: { recipeId in
                        print("onRecipeTapped")
                    }),
                config: MiamRecipesListViewConfig)
            
            }
            .navigationTitle(LocalizedStringKey("tab_catalog")).navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                if showAccount { ShowAccountDependingOnStore(launchAccountSetting: $launchAccount)}
            })
        }
    }
}
