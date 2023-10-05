//
//  UserInformation.swift
//  iosApp
//
//  Created by didi on 4/8/23.
//  Copyright © 2023 Miam. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

enum SignInMethod: Int {
    case withUserId = 2
    case anonymously = 1
    case notSignedIn = 0

    init?(rawValue: Int) {
            switch rawValue {
            case 0:
                self = .notSignedIn
            case 1:
                self = .anonymously
            case 2:
                self = .withUserId
            default:
                return nil
            }
        }
}

class UserInformation: ObservableObject {
    private let userDefaults = UserDefaults.standard
    private let userIdKey = "userId"
    private let signInType = "signInType"
    private let selectedStoreKey = "selectedStore"

    /// Indicates HOW the user is signed in, either withUserId, anonymously, or notSignedIn.
    ///
    /// If the `userId` property is non-nil, then the user is signed in "withUserId".
    /// If the `userId` property is nil and `isAnonymous` is true, then the user is signed in "anonymously".
    /// Otherwise, the user is "notSignedIn".
    @Published var signInMethod: SignInMethod = SignInMethod.notSignedIn

    /// Indicates whether the user HAS a userID & has chosen their store
    ///
    /// If the `userId` property is non-nil && the `selectedStore` property is non-nil, then the user has an account.
    /// Otherwise, the user does not have a complete store.
    @Published var accountHasSelectedStore: Bool = false

    init() {
        signInMethod = signedIn
        accountHasSelectedStore = hasSelectedStore
    }

    var userId: String? {
        get {
            return userDefaults.string(forKey: userIdKey)
        }
        set {
            userDefaults.set(newValue, forKey: userIdKey)
            userDefaults.synchronize()
            withAnimation {
                signedIn = .withUserId
            }

        }
    }

  var hasSelectedStore: Bool {
           get {
               return userId != nil && selectedStore != nil
           }
           set {
               accountHasSelectedStore = newValue
           }
       }

    var selectedStore: String? {
        get {
            return userDefaults.string(forKey: selectedStoreKey)
        }
        set {
            userDefaults.set(newValue, forKey: selectedStoreKey)
            userDefaults.synchronize()
            withAnimation {
                accountHasSelectedStore = hasSelectedStore
            }

        }
    }

   var signedIn: SignInMethod {
       get {
           if let signInMethodRawValue = userDefaults.value(forKey: signInType) as? Int {
               if let methodToSignIn = SignInMethod(rawValue: signInMethodRawValue) {
                   return methodToSignIn
               }
           }
               return .notSignedIn
           }
       set {
           userDefaults.set(newValue.rawValue, forKey: signInType)
           userDefaults.synchronize()
           withAnimation {
               signInMethod = newValue
           }

       }
   }

   func logInAsAnonymous() {
       signedIn = .anonymously
   }

   func logOut() {

//       sign in
       signInMethod = .notSignedIn
       userDefaults.removeObject(forKey: userIdKey)
       userDefaults.removeObject(forKey: signInType)
//       selected store
       accountHasSelectedStore = false
       userDefaults.removeObject(forKey: selectedStoreKey)

   }

    func deleteAccount() {
        logOut()
    }

}
