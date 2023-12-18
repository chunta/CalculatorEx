import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let mainViewController = MainViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else {
            print("Window is not created!!")
            return false
        }
        window.rootViewController = mainViewController
        window.makeKeyAndVisible()

        return true
    }
}

