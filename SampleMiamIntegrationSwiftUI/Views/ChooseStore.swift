//
//  ChooseStore.swift
//  iosApp
//
//  Created by didi on 4/17/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import SwiftUI

struct ChooseStore: View {
    @ObservedObject var userInfo: UserInformation

    @Environment(\.presentationMode) var presentationMode

//    load stores from JSON?
    struct Store: Codable {
        var id: String
        var name: String
    }

    var stores: [Store]?

    init(userInfo: UserInformation) {
        self.userInfo = userInfo

        if let url = Bundle.main.url(forResource: "mock_stores", withExtension: "json") {
            stores = loadObject(from: url, as: [Store].self)
        }
    }

    var body: some View {
        VStack {

            HStack {
                Text("Choose Store")
                    .paragraphTwo()
                    .foregroundColor(.white)
                Spacer()
            }
                .padding(.top, 40)
                    .padding(20)
                    .background(Color("PrimaryColor"))
            List {
                ForEach(stores ?? [], id: \.id) { store in
                    Button {
//                        set the user's store to the id
                        userInfo.selectedStore = store.id
                        // dismiss the sheet
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "building")
                                .foregroundColor(.black)
                                .font(.system(size: 24))
                            VStack {
                                Text(store.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.black)
                                    .paragraphOne()
                                Text(store.id)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.black)
                                    .paragraphTwo()
                            }
                            .padding(.leading, 10)
                        }
                    }

                }
            }
            Spacer()
        }
            .ignoresSafeArea()
    }
}
