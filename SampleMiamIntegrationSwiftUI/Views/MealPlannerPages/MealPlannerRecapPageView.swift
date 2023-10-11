//
//  MealPlannerRecapPageView.swift
//  iosApp
//
//  Created by didi on 23/08/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

struct MealPlannerRecapPageView: View {
    var body: some View {
        MealPlannerRecapView(
            params: MealPlannerRecapParameters(onNavigateAwayFromMealPlanner: {}))
    }
}

struct MealPlannerRecapPageView_Previews: PreviewProvider {
    static var previews: some View {
        MealPlannerRecapPageView()
    }
}
