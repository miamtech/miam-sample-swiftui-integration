//
//  MyMealsView.swift
//  iosApp
//
//  Created by Vincent Kergonna on 19/07/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

struct MyMealsView: View {
    var myMealsBasketViewConfig = BasketRecipesGridConfig(
        recipeHorizontalSpacing: 6.0,
        recipeVerticalSpacing: 6.0,
        productHorizontalSpacing: 6.0,
        productVerticalSpacing: 6.0,
        recipeOverviewDimensions: CGSize(width: 300, height: 150),
        isExpandable: true)
    @ObservedObject var groceriesList: Groceries = Groceries()
    //    binding bool to launch Acc settings determined by TabbedView
    @Binding var launchAccount: Bool
    //    decides if button is shown
    var showAccount: Bool
    
    @EnvironmentObject var tabViewModel: TabViewModel
    
    var body: some View {
        NavigationView {
            MyMealsViewTemplate(
                params: MyMealsParameters(onNoResultsRedirect: {
                    tabViewModel.selectedTab = 3
                }),
                basketRecipesParams: BasketRecipeParameters(
                    onReplaceRecipe: { print("replace recipe") },
                    onShowRecipeDetails: { recipeId in
                        print("showRecipeDetails")
                    }),
                gridConfig: myMealsBasketViewConfig)
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
        }
    }
}

struct MealsView_Previews: PreviewProvider {
    static var previews: some View {
        MyMealsView(launchAccount: .constant(false), showAccount: true)
    }
}
