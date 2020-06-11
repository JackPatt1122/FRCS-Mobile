import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyDq65rYf4d0ksU_HtD8TojgE9s_pfX34GU")
    GMSPlacesClient.provideAPIKey("AIzaSyDq65rYf4d0ksU_HtD8TojgE9s_pfX34GU")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
