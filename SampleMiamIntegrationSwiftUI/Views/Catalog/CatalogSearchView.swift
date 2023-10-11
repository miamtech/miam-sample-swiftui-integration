//
//  CatalogSearchView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework
import miamCore

struct CatalogSearchView: View {
    @Binding var selectedView: String?
    var body: some View {
        CatalogSearchViewTemplate(params: CatalogSearchParameters(
            onApplied: { withAnimation {
                selectedView = "CatalogResults"
            }},
            background: TypeSafeBackground(TestBackground())
        ), singletonFilterViewModel: MiamDI.shared.recipeFilterViewModel
        )
    }
}

struct CatalogSearchView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogSearchView(
            selectedView: .constant(nil)
        )
    }
}
