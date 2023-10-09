//
//  PreferencesView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//
import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

struct PreferencesView: View {
    @Binding var selectedView: String?
    var body: some View {
        PreferencesViewTemplate(params: DefaultPreferencesParams(
            closePreferences: { withAnimation {
                selectedView = nil
                return
            }},
            goToSearchView: { withAnimation {
                selectedView = "PreferencesSearch"
            }}))
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView(
            selectedView: .constant(nil)
        )
    }
}
