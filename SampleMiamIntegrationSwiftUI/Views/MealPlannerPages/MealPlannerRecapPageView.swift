//
//  MealPlannerRecapPageView.swift
//  iosApp
//
//  Created by didi on 23/08/2023.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI
import MiamIOSFramework

struct MealPlannerRecapPageView: View {
    var body: some View {
        MealPlannerRecapView(
            template: MiamMealPlannerRecap(),
            onTapGesture: {})
    }
}

struct MealPlannerRecapPageView_Previews: PreviewProvider {
    static var previews: some View {
        MealPlannerRecapPageView()
    }
}
