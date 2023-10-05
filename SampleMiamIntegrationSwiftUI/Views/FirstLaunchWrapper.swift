//
//  FirstLaunchWrapper.swift
//  iosApp
//
//  Created by didi on 4/17/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI

// used to prompt the sign In page then Select GroceryStore page
struct FirstLaunchWrapper: View {
    @ObservedObject var userInfo: UserInformation

    var body: some View {

//        if not signed in, show signIn option with option for anon
        if userInfo.signInMethod == .notSignedIn {
            SignInView(userInfo: userInfo, showAnonymousSignIn: true)
        }
//        if they have an account, show magusin
        else if !userInfo.hasSelectedStore && userInfo.signInMethod == .withUserId {
            ChooseStore(userInfo: userInfo)
        }
//        otherwise show the signin WITHOUT the anonymous option
        else {
            SignInView(userInfo: userInfo)
        }
    }
}
