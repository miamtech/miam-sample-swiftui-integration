//
//  SignInView.swift
//  iosApp
//
//  Created by didi on 4/6/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var userInfo: UserInformation

    @Environment(\.presentationMode) var presentationMode

//    optional to show sign in anon button
    var showAnonymousSignIn: Bool = false

//    for setting userID
    @State var userIdForInput = ""

    func hasInput() -> Bool {
        if userIdForInput.count > 5 {return true} else {return false}
    }

    var body: some View {
        VStack {
            HStack {
                Text(LocalizedStringKey("sign_in_page"))
                    .paragraphTwo()
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, 40)
                .padding(20)
                .background(Color("PrimaryColor"))
            Spacer()
            Image(systemName: "circle")
            Text(LocalizedStringKey("not_logged_in"))
                .heading()
            Text(LocalizedStringKey("enter_userID"))
                .paragraphOne()
            TextField("UserID", text: $userIdForInput)
                .padding()
                .padding()
            Button {
                print("updating userId to " + userIdForInput)
                userInfo.userId = userIdForInput
            } label: {
                HStack {
                    Spacer()
                    Text(LocalizedStringKey("login_btn"))
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
            }
                .buttonStyle(BasicButton(bgColor: Color("PrimaryColor"), secondaryColor: Color("AccentColor")))
                .disabled(!hasInput())
                .addOpacity(!hasInput())
                .padding(.horizontal)
            Spacer()
            if showAnonymousSignIn {
                Button {
                    userInfo.logInAsAnonymous()
                    // dismiss the sheet
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text(LocalizedStringKey("continue_as_anon"))
                        .foregroundColor(Color("PrimaryColor"))
                }
            }
            Spacer()

        }
        .ignoresSafeArea()

    }
}
