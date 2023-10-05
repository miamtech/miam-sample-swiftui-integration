//
//  NavigationView.swift
//  iosApp
//
//  Created by didi on 4/20/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI

struct ShowAccountDependingOnStore: View {
    @Binding var launchAccountSetting: Bool
    var body: some View {
        Button {
            launchAccountSetting = true
        } label: {
            Image(systemName: "person.crop.circle")
                .foregroundColor(.white)
                .font(.system(size: 24))
        }
    }
}
