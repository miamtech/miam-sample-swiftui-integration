//
//  AccountSettings.swift
//  iosApp
//
//  Created by didi on 4/13/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI

struct AccountSettings: View {
    @ObservedObject var userInfo: UserInformation

    @State var changeUserId = false
    @State var newUserId = ""

    @State var launchChangeStore = false

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Text(LocalizedStringKey("account_settings"))
                    .paragraphTwo()
                    .foregroundColor(.white)
                Spacer()
            }
                .padding(20)
                .background(Color("PrimaryColor"))
            Spacer()

//            perhaps a new comp solo
            VStack {

                Text(LocalizedStringKey("user"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .paragraphTwo()
                    .padding(10)
                Text(String.localizedStringWithFormat(NSLocalizedString("your_userID_is", comment: ""), userInfo.userId ?? ""))
                    .paragraphOne()
                Button {
                    withAnimation {
                        changeUserId.toggle()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text(LocalizedStringKey("change_userId"))
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                    }
                }
                    .buttonStyle(BasicButton(bgColor: Color("PrimaryColor"), secondaryColor: Color("AccentColor")))
                    .padding(.horizontal)
                if changeUserId {
                    TextField("UserID", text: $newUserId)
                        .padding()
                    Button {
                        userInfo.userId = newUserId
                    } label: {
                        Text(LocalizedStringKey("confirm"))
                            .foregroundColor(Color("PrimaryColor"))
                    }
                }
                Button {
                    userInfo.logOut()
                    // dismiss the sheet
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Spacer()
                        Text(LocalizedStringKey("sign_out"))
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                    }
                }
                    .buttonStyle(BasicButton(bgColor: Color("PrimaryColor"), secondaryColor: Color("AccentColor")))
                    .padding(.horizontal)
                Button {
                    userInfo.deleteAccount()
                    // dismiss the sheet
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Spacer()
                        Text(LocalizedStringKey("delete_account"))
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                    }
                }
                    .buttonStyle(BasicButton(bgColor: Color("PrimaryColor"), secondaryColor: Color("AccentColor")))
                    .padding(.horizontal)
            }

            Text(LocalizedStringKey("store"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .paragraphTwo()
                .padding(10)
            Text(String.localizedStringWithFormat(NSLocalizedString("your_store_is", comment: ""), userInfo.selectedStore ?? ""))
                .paragraphOne()
            Button {
                launchChangeStore = true
            } label: {
                HStack {
                    Spacer()
                    Text(LocalizedStringKey("change_store"))
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
            }
                .buttonStyle(BasicButton(bgColor: Color("PrimaryColor"), secondaryColor: Color("AccentColor")))
                .padding(.horizontal)
                .sheet(isPresented: $launchChangeStore, content: {ChooseStore(userInfo: userInfo)})

            Spacer()
        }
        .ignoresSafeArea()

    }
}
