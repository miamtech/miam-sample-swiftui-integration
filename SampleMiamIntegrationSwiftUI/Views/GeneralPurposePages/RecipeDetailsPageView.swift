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

class RecipeDetailsParams: RecipeDetailsViewParameters {
    public var closeRecipeDetails: () -> Void
    public var sponsorDetailsTapped: (Sponsor) -> Void
    public init(
        closeRecipeDetails: @escaping () -> Void,
        sponsorDetailsTapped: @escaping (Sponsor) -> Void
    ) {
        self.closeRecipeDetails = closeRecipeDetails
        self.sponsorDetailsTapped = sponsorDetailsTapped
    }
}

struct RecipeDetailsView: View {
    var popRecipeDetails: () -> Void
    var launchSponsorDetails: () -> Void
    @Binding var selectedRecipe: String
    @Binding var selectedSponsor: Sponsor?
    
    var body: some View {
        RecipeDetails(params: RecipeDetailsParams(
            closeRecipeDetails: popRecipeDetails,
            sponsorDetailsTapped: { sponsor in
                selectedSponsor = sponsor
                launchSponsorDetails()
            }), recipeId: selectedRecipe)
    }
}
