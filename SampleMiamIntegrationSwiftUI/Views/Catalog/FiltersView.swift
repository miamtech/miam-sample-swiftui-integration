//
//  FiltersView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

struct FiltersView: View {
    @Binding var selectedView: String?
    var body: some View {
        CatalogFilterViewTemplate(params: FiltersParams(
            applyFilters: {
                withAnimation {
                    selectedView = "CatalogResults"
                }
            }, closeFilters: {
                withAnimation {
                    selectedView = nil
                }
            })
        )
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(
            selectedView: .constant(nil)
        )
    }
}
