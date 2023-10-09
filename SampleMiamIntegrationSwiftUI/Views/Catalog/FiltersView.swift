//
//  FiltersView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

struct FiltersPage: View {
    @Binding var selectedView: String?
    var body: some View {
        FiltersView(params: FiltersParams(
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

struct FiltersPage_Previews: PreviewProvider {
    static var previews: some View {
        FiltersPage(
            selectedView: .constant(nil)
        )
    }
}
