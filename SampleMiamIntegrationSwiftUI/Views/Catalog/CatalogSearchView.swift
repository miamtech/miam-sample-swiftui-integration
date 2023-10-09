//
//  CatalogSearchView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework


struct CatalogSearchView: View {
    @Binding var selectedView: String?
    var body: some View {
        CatalogSearchViewTemplate(params: CatalogSearchParams(
            applySearch: {
                withAnimation {
                    selectedView = "CatalogResults"
                }
            },
            customBackground: TypeSafeBackground(TestBackground())
        )
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
