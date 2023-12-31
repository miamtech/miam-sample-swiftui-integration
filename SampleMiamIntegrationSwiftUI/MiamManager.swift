//
//  MiamManager.swift
//  iosApp
//
//  Created by Miam on 19/04/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
import miamCore
import MiamIOSFramework
import SwiftUI
import Combine

@available(iOS 14, *)
public class Categories: ObservableObject {
    @Published var categoriesList: [CatalogCategory]  = []
}

public class MiamManager: ObservableObject {
    public static let sharedInstance = MiamManager()
    private let availableStoreIdLists = ["454", "652"]
    private let basketHandler: BasketHandler
    private var cancelable: AnyCancellable?
    public let categories = Categories()

    @Published var isReady: Bool = false

    func isActiveOnStore() -> KotlinBoolean {
        return  KotlinBoolean(value: availableStoreIdLists.contains("35290"))
    }

    // need to be private
    private init() {
        LogHandler.companion.info("Are you ready ? \(ContextHandlerInstance.shared.instance.isReady())")

        UserPreferencesInstance.shared.instance.putInt(key: "testInt", value: 42)
        UserPreferencesInstance.shared.instance.putList(key: "testString", value: ["1", "2", "3"])
        print("IntPref success \( UserPreferencesInstance.shared.instance.getIntOrNull(key: "testInt"))")
        print("ListPref success \( UserPreferencesInstance.shared.instance.getListOrNull(key: "testString"))")
        basketHandler = BasketHandlerInstance.shared.instance
        basketHandler.setListenToRetailerBasket(func: initBasketListener)
        basketHandler.setPushProductsToRetailerBasket(func: pushProductToBasket)
        basketHandler.pushProductsToMiamBasket(retailerBasket: [])
        PointOfSaleHandler.shared.setSupplier(supplierId: 7)
        PointOfSaleHandler.shared.setSupplierOrigin(origin: "app.coursesu.com")
        PointOfSaleHandler.shared.updateStoreId(storeId: "23824")
        UserHandler.shared.updateUserId(userId: "test_\(UUID())")
        PointOfSaleHandler.shared.isAvailable = isActiveOnStore
        PointOfSaleHandler.shared.getCatalogCategories { categories in
            self.categories.categoriesList = categories
        }
        UserHandler.shared.setProfilingAllowed(allowance: true)
        UserHandler.shared.setEnableLike(isEnable: true)

        AnalyticsInstance.shared.instance.setOnEventEmitted( onEventEmittedCallBack: {event in  print("event Miam \(event.eventType)  \(event.path)  \(event.props)")})

        // initTemplate()
//        var theme = MiamTheme.shared
//        theme.templates.budget.callToAction = DemoBudgetCallToAction()

        ContextHandlerInstance.shared.instance.onReadyEvent(callback: { event in
            print("Miam event recived \(event)")
            self.isReady = event is ReadyEvent.isReady
        })
    }

    private func yourProductsToRetailerProducts(products: [MyProduct]) -> [RetailerProduct] {
        return products.map {
            return RetailerProduct(
                retailerId: $0.id,
                quantity: Int32($0.quantity),
                name: $0.name,
                productIdentifier: nil
            )
        }
    }

    private func pushProductToBasket(products: [RetailerProduct]) {
        let miamProducts = retailerProductsToYourProducts(products: products)
        let initialItems = MyBasket.shared.items
        var finalItems = initialItems.compactMap { retailerProduct in updatedProductOrNil(retailerProduct: retailerProduct, miamProducts: miamProducts) }
        miamProducts.forEach({ miamProduct in
            if (!finalItems.contains(where: { retailerProducts in retailerProducts.id == miamProduct.id })) {
                finalItems.append(miamProduct)
            }
        })
        MyBasket.shared.items = finalItems
    }

    private func updatedProductOrNil(retailerProduct: MyProduct, miamProducts: [MyProduct]) -> MyProduct? {
        let updatedProduct = miamProducts.first(where: { miamProduct in miamProduct.id.isEqual(retailerProduct.id)})
        if updatedProduct == nil {
            return retailerProduct
        }
        if updatedProduct!.quantity == 0 {
            return nil
        }
        retailerProduct.quantity = updatedProduct!.quantity
        return retailerProduct
    }

    private func retailerProductsToYourProducts(products: [RetailerProduct]) -> [MyProduct] {
        return products.map {
            return   MyProduct(
                id: $0.retailerId,
                name: "\($0.name)",
                quantity: Int($0.quantity)
            )
        }
    }

    private func initBasketListener() {
        cancelable = MyBasket.shared.$items.sink { receiveValue in
            self.basketHandler.pushProductsToMiamBasket(
                retailerBasket: self.yourProductsToRetailerProducts(products: receiveValue)
            )
        }
    }

    private func getTotalPayment() -> KotlinDouble {
        return 2.0
    }

    private func initCustomText() {
        MiamText.sharedInstance.alreadyInCart = "c'est dans la boite"
    }

    private func initTemplate() {
        Template.sharedInstance.recipesListCategoryTitleTemplate = {(coco: CatalogPageTitleTemplateParameters
          ) -> AnyView in
            AnyView(
                VStack {
                    Text(coco.title)
                    Text(coco.subtitle ?? "niooooo")
                }
            )}
    }
}
