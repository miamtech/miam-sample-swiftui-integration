//
//  SponsorDetailView.swift
//  SampleMiamIntegrationSwiftUI
//
//  Created by didi on 05/10/2023.
//

import SwiftUI
import MiamIOSFramework
import miamCore
import MiamNeutraliOSFramework

struct SponsorDetailView: View {
    @Binding var selectedSponsor: Sponsor?
    
    var body: some View {
        if let selectedSponsor {
            SponsorDetailViewTemplate(
                params: SponsorDetailsParameters(),
                sponsor: selectedSponsor)
        }
    }
}
