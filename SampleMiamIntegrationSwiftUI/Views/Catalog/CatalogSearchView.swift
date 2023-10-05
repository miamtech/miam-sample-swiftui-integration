//
//  CatalogSearchView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//

import SwiftUI
import MiamIOSFramework

/// This sets the Templates for the PreferencesSearchView Overview
public class CatalogSearchParameters: CatalogSearchViewParameters {
    public var applySearch: () -> Void
    public init(
        applySearch: @escaping () -> Void
    ) {
        self.applySearch = applySearch
    }
}

struct CatalogSearchView: View {
    @Binding var navigationStack: [CatalogNavigationState]
    var body: some View {
        CatalogSearchViewTemplate(params: CatalogSearchParameters(
            applySearch: {
                withAnimation {    
                    navigationStack.removeLast()
                    navigationStack.append(.catalogResults)
                }
            })
        )
    }
}

struct CatalogSearchView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogSearchView(
            navigationStack: .constant([.catalog])
        )
    }
}
