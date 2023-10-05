import SwiftUI
import MiamIOSFramework
import miamCore

@available(iOS 15, *)
struct MealIdeas: View {
    //    binding bool to launch Acc settings determined by TabbedView
    @Binding var launchAccount: Bool
    //    decides if button is shown
    var showAccount: Bool

    @SwiftUI.State private var recipeCount: Int = 0
    @SwiftUI.State private var showTag: Bool = false
    @SwiftUI.State private var showRecipeCount: Bool = false
    @SwiftUI.State private var showRecipesSearch = false
    @SwiftUI.State private var showResults = false
    @SwiftUI.State private var showMealPlanner: Bool = false

    @StateObject private var miamManager = MiamManager.sharedInstance

    var criteria = SuggestionsCriteria(
        shelfIngredientsIds: ["5319173", "970417", "1088020"],
        currentIngredientsIds: nil,
        basketIngredientsIds: nil,
        groupId: nil
    )

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            NavigationView {
                VStack {
                    Button("change store", action: { BasketHandlerInstance.shared.instance.setPriceBookKey(priceBookKey: "LIV")

                    })
                    ScrollView {
//                        NavigationLink(isActive: $showMealPlanner) {
//                            MealPlanner(showMealPlanner: $showMealPlanner)
//                        } label: {
//                            MealPlannerCallToActionView(
//                                template: MiamBudgetCallToAction(),
//                                onTapGesture: {
//                                    showMealPlanner.toggle()
//                                }
//                            )
//                        }
//                        .padding([.top], Dimension.sharedInstance.mPadding)

                        if miamManager.isReady {
                            Button("toggle tag", action: { showTag = !showTag})
                            CategoriesMenu(categorie: MiamManager.sharedInstance.categories)
                            VStack(spacing: 24.0) {
                                if showTag {
                                    BasketTagView(itemId: "1088020")
                                }

                                RecipeCardView(recipeId: "9422")

                                ForEach(0..<5) { _ in
                                    if let product = MyProductsRepository().getRandomProduct() {
                                        RecipeCardView(criteria: SuggestionsCriteria(
                                            shelfIngredientsIds: [product.id],
                                            currentIngredientsIds: nil,
                                            basketIngredientsIds: nil,
                                            groupId: nil
                                        ))
                                    }
                                }
                            }
                        }
                    }
                    .padding([.leading, .trailing, .bottom], 16.0)
                }
                .navigationTitle(LocalizedStringKey("tab_products")).navigationBarTitleDisplayMode(.inline)
                    .toolbar(content: {
                        if showAccount { ShowAccountDependingOnStore(launchAccountSetting: $launchAccount)}
                    })
            }
        }
    }

    @available(iOS 15, *)
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            MealIdeas(launchAccount: .constant(false), showAccount: true)
        }
    }
}
