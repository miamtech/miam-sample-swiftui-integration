//
//  PreferencesSearchView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//

import SwiftUI
import MiamIOSFramework

/// This sets the Templates for the PreferencesSearchView Overview
public class PreferencesSearchParameters: PreferencesSearchViewParameters {
    public var closeSearch: () -> Void
    public init(
        closeSearch: @escaping () -> Void
    ) {
        self.closeSearch = closeSearch
    }
}

struct PreferencesSearchView: View {
    @Binding var navigationStack: [CatalogNavigationState]
    var body: some View {
        PreferencesSearchViewTemplate(params: PreferencesSearchParameters(
            closeSearch: { withAnimation {
                navigationStack.removeLast()
                return
            }}))
    }
}

struct PreferencesSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesSearchView(
            navigationStack: .constant([.catalog])
        )
    }
}
