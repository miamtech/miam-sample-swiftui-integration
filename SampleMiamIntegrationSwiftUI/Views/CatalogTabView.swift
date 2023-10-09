//
//  catalogTabView.swift
//  iosApp
//
//  Created by Miam on 27/07/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import MiamIOSFramework
import MiamNeutraliOSFramework
import miamCore

struct CatalogTabView: View {
    // binding bool to launch Acc settings determined by TabbedView
    @Binding var launchAccount: Bool
    // decides if button is shown
    var showAccount: Bool
    @SwiftUI.State private var selectedRecipe: String = "Catalog"
    @SwiftUI.State private var selectedSponsor: Sponsor? = nil
    
    @SwiftUI.State private var selectedView: String? = nil
    
    struct PageWithHeader<Content: View>: View {
        private let view: Content
        @Binding var selectedView: String?
        
        init(
             selectedView: Binding<String?>,
             view: Content) {
            self.view = view
            _selectedView = selectedView
        }
        var body: some View {
            view
                .navigationBarItems(leading: Button(action: {
                    selectedView = nil
                }) {
                    Text("Back")
                }.foregroundColor(Color.white))
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    var body: some View {
//        if #available(iOS 16, *) {
//            NavigationStack {
//                navContent()
//            }
//        } else {
            NavigationView {
                navContent()
            }
//        }
    }
    
    func navContent() -> some View {
        return VStack {
            NavigationLink(
                destination:
                    MealPlanner(selectedView: $selectedView)
                    .transition(.moveAndFade)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Meal Planner")
                , tag: "MealPlanner", selection: $selectedView) { EmptyView() }
            NavigationLink(
                destination:
                    PageWithHeader(
                        selectedView: $selectedView,
                        view: PreferencesView(selectedView: $selectedView))
                    .navigationTitle("Preferences")
                , tag: "Preferences", selection: $selectedView) { EmptyView() }
            NavigationLink(
                destination:
                    PageWithHeader(
                        selectedView: $selectedView,
                        view: PreferencesSearchView(selectedView: $selectedView))
                    .navigationTitle("PreferencesSearch")
                , tag: "PreferencesSearch", selection: $selectedView) { EmptyView() }
            NavigationLink(
                destination:
                    PageWithHeader(
                        selectedView: $selectedView,
                        view: FiltersPage(selectedView: $selectedView))
                    .navigationTitle("Filters")
                , tag: "Filters", selection: $selectedView) { EmptyView() }
            NavigationLink(
                destination:
                    PageWithHeader(
                        selectedView: $selectedView,
                        view: CatalogSearchView(selectedView: $selectedView))
                    .navigationTitle("CatalogSearch")
                , tag: "CatalogSearch", selection: $selectedView) { EmptyView() }
            NavigationLink(
                destination:
                    PageWithHeader(
                        selectedView: $selectedView,
                        view: CatalogResultsView(
                            selectedView: $selectedView,
                            selectedRecipe: $selectedRecipe))
                    .navigationTitle("CatalogResults")
                , tag: "CatalogResults", selection: $selectedView) { EmptyView() }
            NavigationLink(
                destination:
                    RecipeDetailsView(
                        popRecipeDetails: { withAnimation {
                            selectedView = nil
                            return
                        }},
                        launchSponsorDetails: { withAnimation {
                            selectedView = "SponsorDetails"
                        }},
                        selectedRecipe: $selectedRecipe,
                        selectedSponsor: $selectedSponsor)
                    .navigationTitle("Recipe Details")
                , tag: "RecipeDetails", selection: $selectedView) { EmptyView() }
            NavigationLink(
                destination:
                    PageWithHeader(
                        selectedView: $selectedView,
                        view: SponsorDetailView(
                            selectedSponsor: $selectedSponsor))
                    .navigationTitle("SponsorDetails")
                , tag: "SponsorDetails", selection: $selectedView) { EmptyView() }
            CatalogView(
                selectedRecipe: $selectedRecipe,
                selectedView: $selectedView)
            .navigationTitle(LocalizedStringKey("tab_catalog"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
