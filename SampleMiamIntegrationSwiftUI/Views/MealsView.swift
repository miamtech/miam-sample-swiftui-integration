//
//  MealsView.swift
//  iosApp
//
//  Created by Vincent Kergonna on 19/07/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import MiamIOSFramework

struct MealsView: View {
    @ObservedObject var groceriesList: Groceries = Groceries()
//    binding bool to launch Acc settings determined by TabbedView
    @Binding var launchAccount: Bool
//    decides if button is shown
    var showAccount: Bool

    var body: some View {

        NavigationView {
            MyMealsView()
                .navigationTitle("Mes repas (\(groceriesList.numberOfRecipes))").navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    Button {
                        groceriesList.reset()
                    } label: {
                        Label("Vider", systemImage: "trash.slash.fill").foregroundColor(Color.red)
                    }
                    if showAccount { ShowAccountDependingOnStore(launchAccountSetting: $launchAccount)}

                })
        }.onAppear {
//            groceriesList.refreshRecipeCount()
        }
    }
}

struct MealsView_Previews: PreviewProvider {
    static var previews: some View {
        MealsView(launchAccount: .constant(false), showAccount: true)
    }
}
