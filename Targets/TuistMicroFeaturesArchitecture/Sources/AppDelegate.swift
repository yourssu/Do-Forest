import UIKit
import TuistMicroFeaturesArchitectureKit
import TuistMicroFeaturesArchitectureUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        TuistMicroFeaturesArchitectureKit.hello()
        TuistMicroFeaturesArchitectureUI.hello()

        return true
    }

}
