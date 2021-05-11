import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyAJZv7luVqour5IPa4eFaKjYgRW0BGEpaw")
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    
    var flutter_native_splash = 1
    UIApplication.shared.isStatusBarHidden = false
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    
    let localeChannel = FlutterMethodChannel(name: "io.trytiptop.native_channel", binaryMessenger: controller.binaryMessenger)
    localeChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        // Note: this method is invoked on the UI thread.
        // Handle changing the lcoale.
        print("===============")
        print("call")
        print("\(call.method)")
        print("===============")

        if(call.method == "change_language" ){
            if let args = call.arguments as? Dictionary<String, Any>,
               let passedLocale = args["locale"] as? String {
                UserDefaults.standard.set([passedLocale], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                print("========= changed langauge to:")
                print("\(passedLocale)")
                
                // Restart App
                // Todo: work on restarting the application.
                //let controller : FlutterViewController = self.window?.rootViewController as! FlutterViewController
                //self.window.rootViewController = controller
                
                result(nil)
            } else {
                result(FlutterError.init(code: "errorSetDebug", message: "data or format error", details: nil))
            }
            
            
            result(FlutterMethodNotImplemented)
            
            return
        }
    })
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
