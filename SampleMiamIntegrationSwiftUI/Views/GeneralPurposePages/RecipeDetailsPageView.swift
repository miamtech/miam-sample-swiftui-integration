//
//  RecipeDetailsView.swift
//  iosApp
//
//  Created by didi on 23/08/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework
import miamCore
import MiamNeutraliOSFramework

struct RecipeDetailsView: View {
    var popRecipeDetails: () -> Void
    var launchSponsorDetails: () -> Void
    @Binding var selectedRecipe: String
    @Binding var selectedSponsor: Sponsor?
    
    var body: some View {
        RecipeDetails(params: RecipeDetailParameters(
            onClosed: popRecipeDetails,
            onSponsorDetailsTapped: { sponsor in
                selectedSponsor = sponsor
                launchSponsorDetails()
            }), recipeId: selectedRecipe)
    }
}
