import SwiftUI
import miamCore

class TabViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
}

@main
struct SampleMiamIntegrationSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            TabbedView()
                .environmentObject(TabViewModel())
        }
    }

}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _ = MiamManager.sharedInstance

//        // for styling top nav bar
        let appearance = UINavigationBarAppearance()
        if let navBarColor = UIColor(named: "PrimaryColor") {
            appearance.backgroundColor = navBarColor
        }
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        return true
    }
}
