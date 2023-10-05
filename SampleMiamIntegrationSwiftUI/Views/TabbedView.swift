//
//  TabbedView.swift
//  iosApp
//
//  Created by Vincent Kergonna on 19/07/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import MiamIOSFramework

struct TabbedView: View {
    let applicationBasket: MyBasket = MyBasket.shared

    @ObservedObject var userInfo = UserInformation()
    @State var launchSignInButton = false
    @State var launchAccountSetting = false

    // higher order function to check if user hasAccount (NOT just signed in anonymously) -> otherwise shows SignInView
    func tabRequiresAccount<V: View>(@ViewBuilder content: () -> V, label: LocalizedStringKey, systemImage: String) -> some View {
        return VStack {
            if userInfo.hasSelectedStore && userInfo.signInMethod == .withUserId {content()} else {YouMustLogIn(userInfo: userInfo)}
        }
        .tabItem {
            Label(label, systemImage: systemImage)
        }
    }

    // if NOT signed in OR they are signed in YET they haven't selected a store
    var shouldPresentSheet: Bool {
        return userInfo.signInMethod == .notSignedIn
        ||  (!userInfo.hasSelectedStore && userInfo.signInMethod == .withUserId)
    }

    // simple func to decide whether or not account settings is shown -> i use this instead of needing to pass userInfo into subclasses
    func decideShowAccountSettings() -> Bool {
        if userInfo.hasSelectedStore { return true } else { return false }
       }

    var body: some View {
        TabView {
            if #available(iOS 15, *) {
                MealIdeas(launchAccount: $launchAccountSetting, showAccount: decideShowAccountSettings())
                    .tabItem {
                        Label(LocalizedStringKey("tab_products"), systemImage: "questionmark.square")
                            .accessibilityIdentifier("tab_meal_ideas")
                    }
            }
            tabRequiresAccount(content: {
                MealsView(launchAccount: $launchAccountSetting,
                          showAccount: decideShowAccountSettings())},
                               label: LocalizedStringKey("tab_meals"),
                               systemImage: "fork.knife.circle")
            tabRequiresAccount(content: {
                MyBasketView(launchAccount: $launchAccountSetting,
                             showAccount: decideShowAccountSettings())},
                               label: LocalizedStringKey("tab_basket"),
                               systemImage: "cart.fill")
            tabRequiresAccount(content: {
                CatalogTabView(launchAccount: $launchAccountSetting,
                               showAccount: decideShowAccountSettings())},
                               label: LocalizedStringKey("tab_catalog"),
                               systemImage: "book.fill")
            tabRequiresAccount(content: {
                MyFavoritesView(launchAccount: $launchAccountSetting,
                                showAccount: decideShowAccountSettings())},
                               label: LocalizedStringKey("tab_favorites"),
                               systemImage: "heart.fill")
        }
        .background(Color.white)
        .accentColor(Color("PrimaryColor"))
        .ignoresSafeArea()
        .sheet(isPresented: $launchAccountSetting, content: {AccountSettings(userInfo: userInfo)})
        .onAppear {
            if shouldPresentSheet {launchSignInButton=true}
        }
    }
}
