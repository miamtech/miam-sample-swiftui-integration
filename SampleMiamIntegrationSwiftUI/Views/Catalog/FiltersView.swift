//
//  FiltersView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//

import SwiftUI
import MiamIOSFramework

/// This sets the Templates for the PreferencesSearchView Overview
public class FiltersParameters: CatalogFilterViewParameters {
    public var applyFilters: () -> Void
    public var closeFilters: () -> Void
    public init(
        applyFilters: @escaping () -> Void,
        closeFilters: @escaping () -> Void
    ) {
        self.applyFilters = applyFilters
        self.closeFilters = closeFilters
    }
}

struct FiltersView: View {
    @Binding var navigationStack: [CatalogNavigationState]
    var body: some View {
        CatalogFilterViewTemplate(params: FiltersParameters(
            applyFilters: {
                withAnimation {
                    navigationStack.removeLast()
                    navigationStack.append(.catalogResults)
                }
            }, closeFilters: {
                withAnimation {
                    navigationStack.removeLast()
                    return
                }
            })
        )
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(
            navigationStack: .constant([.catalog])
        )
    }
}
