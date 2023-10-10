//
//  PreferencesSearchView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework

struct PreferencesSearchView: View {
    @Binding var selectedView: String?
    var body: some View {
        PreferencesSearchViewTemplate(params: PreferencesSearchParameters(
            onClosed: { withAnimation {
                selectedView = nil
            }}))
    }
}

struct PreferencesSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesSearchView(
            selectedView: .constant(nil)
        )
    }
}
