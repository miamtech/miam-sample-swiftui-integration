//
//  MealsView.swift
//  iosApp
//
//  Created by Vincent Kergonna on 19/07/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

struct MealsView: View {
    var MyMealsBasketViewConfig = BasketRecipesViewConfig(
        recipesSpacing: 8.0,
        productsSpacing: 8.0,
        recipeOverviewDimensions: CGSize(width: 150, height: 150),
        isExpandable: true
    )
    @ObservedObject var groceriesList: Groceries = Groceries()
    //    binding bool to launch Acc settings determined by TabbedView
    @Binding var launchAccount: Bool

    @State var openItemSelector = false
    @State var selectedRecipe = ""
    @State private var navigationStack: [MealPlannerNavigationState] = []
    
    //    decides if button is shown
    var showAccount: Bool
    
    var body: some View {
        NavigationView {
            MyMealsViewTemplate(
                params: DefaultBaseViewParams(),
                basketRecipesParams: BasketRecipeParameters(
                    onReplaceProduct: { recipeId in
                        selectedRecipe = recipeId
                        openItemSelector = true
                    },
                    onShowRecipeDetails: { recipeId in
                        print("showRecipeDetails")
                    }
                ),
                config: MyMealsBasketViewConfig)
            .navigationTitle("Mes repas (\(groceriesList.numberOfRecipes))").navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button {
                    groceriesList.reset()
                } label: {
                    Label("Vider", systemImage: "trash.slash.fill").foregroundColor(Color.red)
                }
                if showAccount { ShowAccountDependingOnStore(
                    launchAccountSetting: $launchAccount
                )}
            })
        }.sheet(isPresented: $openItemSelector, content: { ItemSelector(
            params: ItemSelectorParameters(onItemSelected: { openItemSelector = false} ),
            recipeId: selectedRecipe) })
    }
}

struct MealsView_Previews: PreviewProvider {
    static var previews: some View {
        MealsView(launchAccount: .constant(false), showAccount: true)
    }
}
