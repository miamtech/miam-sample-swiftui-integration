//
//  FiltersView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework
import miamCore

struct FiltersPage: View {
    @Binding var selectedView: String?
    @Binding var selectedFilterViewModel: SingletonFilterViewModel
    var body: some View {
        FiltersView(params: FiltersParameters(
            onApplied: {
                withAnimation { selectedView = "CatalogResults" }
            }, onClosed: {
                withAnimation { selectedView = nil }
            },
            viewOptions: FiltersParamsViewOptions(
                callToAction: TypeSafeFiltersCTA(MiamNeutralFiltersCTA()),
                background: TypeSafeBackground(TestBackground())
            )
        ), singletonFilterViewModel: selectedFilterViewModel)
    }
}


struct FiltersPage_Previews: PreviewProvider {
    static var previews: some View {
        FiltersPage(
            selectedView: .constant(nil),
            selectedFilterViewModel: .constant(MiamDI.shared.recipeFilterViewModel)
        )
    }
}
