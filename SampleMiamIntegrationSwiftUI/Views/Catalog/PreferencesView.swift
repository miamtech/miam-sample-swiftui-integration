//
//  PreferencesView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//
import SwiftUI
import MiamIOSFramework

/// This sets the Templates for the CatalogFiltersPage Overview
public class MiamNeutralPreferencesViewParameters: PreferencesViewParameters {
    public var closePreferences: () -> Void
    public var goToSearchView: () -> Void
    public init(
        closePreferences: @escaping () -> Void,
        goToSearchView: @escaping () -> Void
    ) {
        self.closePreferences = closePreferences
        self.goToSearchView = goToSearchView
    }
}

struct PreferencesView: View {
    @Binding var navigationStack: [CatalogNavigationState]
    var body: some View {
        PreferencesViewTemplate(params: MiamNeutralPreferencesViewParameters(
            closePreferences: {
                print("close")
            },
            goToSearchView: {
                print("go to search")
            }))
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView(
            navigationStack: .constant([.catalog])
        )
    }
}
