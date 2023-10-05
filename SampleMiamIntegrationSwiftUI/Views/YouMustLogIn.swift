//
//  YouMustLogIn.swift
//  iosApp
//
//  Created by didi on 4/17/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI

struct YouMustLogIn: View {
    @ObservedObject var userInfo: UserInformation

    @State var launchLogIn = false

    var body: some View {
        VStack {
            Spacer()
            Text("You must log in")
                .heading()
            Button {
                launchLogIn = true
            } label: {
                HStack {
                    Spacer()
                    Text("LOGIN")
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
            }
                .buttonStyle(BasicButton(bgColor: Color("PrimaryColor"), secondaryColor: Color("AccentColor")))
                .padding(.horizontal)
            Spacer()
        }
        .sheet(isPresented: $launchLogIn, content: {FirstLaunchWrapper(userInfo: userInfo)})
    }

}
