//
//  PluggableApplicationDelegate.swift
//  PluggableApplicationDelegate
//
//  Created by Fernando Ortiz on 2/24/17.
//  Copyright © 2017 Fernando Martín Ortiz. All rights reserved.
//

import UIKit
import CloudKit

/// This is only a tagging protocol.
/// It doesn't add more functionalities yet.
public protocol ApplicationService: UIApplicationDelegate {}

extension ApplicationService {
    @nonobjc public var window: UIWindow? {
        get {
            return UIApplication.shared.delegate?.window ?? nil
        } set(newValue) {
            (UIApplication.shared.delegate as? PluggableApplicationDelegate)?.window = newValue
        }
    }
}

open class PluggableApplicationDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
  
    open var services: [ApplicationService] { return [] }
    private lazy var __services: [ApplicationService] = {
        return self.services
    }()
    
    @available(iOS 2.0, *)
    open func applicationDidFinishLaunching(_ application: UIApplication) {
        __services.forEach { $0.applicationDidFinishLaunching?(application) }
    }
    
    
    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        var result = true
        for service in __services {
            if service.application?(application, willFinishLaunchingWithOptions: launchOptions) == false {
                result = false
            }
        }
        return result
    }
    
    @available(iOS 3.0, *)
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        var result = true
        for service in __services {
            if service.application?(application, didFinishLaunchingWithOptions: launchOptions) == false {
                result = false
            }
        }
        return result
    }
    
    
    @available(iOS 2.0, *)
    open func applicationDidBecomeActive(_ application: UIApplication) {
        for service in __services {
            service.applicationDidBecomeActive?(application)
        }
    }
    
    @available(iOS 2.0, *)
    open func applicationWillResignActive(_ application: UIApplication) {
        for service in __services {
            service.applicationWillResignActive?(application)
        }
    }
    
    @available(iOS, introduced: 2.0, deprecated: 9.0, message: "Please use application:openURL:options:")
    open func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        var result = true
        for service in __services {
            if service.application?(application, handleOpen: url) == false {
                result = false
            }
        }
        return result
    }
    
    @available(iOS, introduced: 4.2, deprecated: 9.0, message: "Please use application:openURL:options:")
    open func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        var result = true
        for service in __services {
            if service.application?(application, open: url, sourceApplication: sourceApplication, annotation: annotation) == false {
                result = false
            }
        }
        return result
    }
    
    @available(iOS 9.0, *)
    open func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        var result = true
        for service in __services {
            if service.application?(app, open: url, options: options) == false {
                result = false
            }
        }
        return result
    }
    
    @available(iOS 2.0, *)
    open func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        for service in __services {
            service.applicationDidReceiveMemoryWarning?(application)
        }
    }
    
    @available(iOS 2.0, *)
    open func applicationWillTerminate(_ application: UIApplication) {
        for service in __services {
            service.applicationWillTerminate?(application)
        }
    }
    
    @available(iOS 2.0, *)
    open func applicationSignificantTimeChange(_ application: UIApplication)  {
        for service in __services {
            service.applicationSignificantTimeChange?(application)
        }
    }
    
    
    @available(iOS 2.0, *)
    open func application(_ application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        for service in __services {
            service.application?(application, willChangeStatusBarOrientation: newStatusBarOrientation, duration: duration)
        }
    }
    
    @available(iOS 2.0, *)
    open func application(_ application: UIApplication, didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {
        for service in __services {
            service.application?(application, didChangeStatusBarOrientation: oldStatusBarOrientation)
        }
    }
    
//    open func application(_ application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {
//        for service in __services {
//            service.application?(application, willChangeStatusBarFrame: newStatusBarFrame)
//        }
//    }
//
//    open func application(_ application: UIApplication, didChangeStatusBarFrame oldStatusBarFrame: CGRect) {
//        for service in __services {
//            service.application?(application, didChangeStatusBarFrame: oldStatusBarFrame)
//        }
//    }
    
    
    // This callback will be made upon calling -[UIApplication registerUserNotificationSettings:]. The settings the user has granted to the application will be passed in as the second argument.
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotification UNNotification Settings instead")
    open func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        for service in __services {
            service.application?(application, didRegister: notificationSettings)
        }
    }
    
    
    @available(iOS 3.0, *)
    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        for service in __services {
            service.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }
    
    
    @available(iOS 3.0, *)
    open func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        for service in __services {
            service.application?(application, didFailToRegisterForRemoteNotificationsWithError: error)
        }
    }
    
    
    @available(iOS, introduced: 3.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")
    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        for service in __services {
            service.application?(application, didReceiveRemoteNotification: userInfo)
        }
    }
    
    
    @available(iOS, introduced: 4.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
    open func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        for service in __services {
            service.application?(application, didReceive: notification)
        }
    }
    
    private func waitServicesCompletion<T, R>(_ serviceCall: (_ service: UIApplicationDelegate, _ completion:  @escaping (T) -> Swift.Void) -> R?, callbackAggregation: (([T]) -> T)? = nil, completion: @escaping (T) -> Swift.Void, resultAggregation: (([R]) -> R)? = nil) -> R? {
        let group = DispatchGroup()
        var completionResults = [T]()
        var results = [R]()
        for service in __services {
            group.enter()
            if let result = serviceCall(service, { result in
                completionResults.append(result)
                group.leave()
            }) {
                results.append(result)
            }
            
        }
        group.notify(queue: DispatchQueue.main) {
            if let completionResult = callbackAggregation?(completionResults) ?? completionResults.first {
                completion(completionResult)
            }
        }
        return resultAggregation?(results) ?? results.first
    }
    
    // Called when your app has been activated by the user selecting an action from a local notification.
    // A nil action identifier indicates the default action.
    // You should call the completion handler as soon as you've finished handling the action.
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
    open func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Swift.Void) {
        waitServicesCompletion(
            { $0.application?(application, handleActionWithIdentifier: identifier, for: notification, completionHandler: $1)},
            completion: completionHandler)
    }
    
    
    @available(iOS, introduced: 9.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
    open func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], withResponseInfo responseInfo: [AnyHashable : Any], completionHandler: @escaping () -> Swift.Void) {
        waitServicesCompletion(
            { $0.application?(application, handleActionWithIdentifier: identifier, forRemoteNotification: userInfo, withResponseInfo: responseInfo, completionHandler: $1) },
            completion: completionHandler)
    }
    
    
    // Called when your app has been activated by the user selecting an action from a remote notification.
    // A nil action identifier indicates the default action.
    // You should call the completion handler as soon as you've finished handling the action.
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
    open func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], completionHandler: @escaping () -> Swift.Void) {
        waitServicesCompletion(
            { $0.application?(application, handleActionWithIdentifier: identifier, forRemoteNotification: userInfo, completionHandler: $1)},
            completion: completionHandler)
    }
    
    
    @available(iOS, introduced: 9.0, deprecated: 10.0, message: "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:]")
    open func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, withResponseInfo responseInfo: [AnyHashable : Any], completionHandler: @escaping () -> Swift.Void) {
        waitServicesCompletion(
            { $0.application?(application, handleActionWithIdentifier: identifier, for: notification, withResponseInfo: responseInfo, completionHandler: $1) },
            completion: completionHandler)
    }
    
    
    /*! This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
     
     This method will be invoked even if the application was launched or resumed because of the remote notification. The respective delegate methods will be invoked first. Note that this behavior is in contrast to application:didReceiveRemoteNotification:, which is not called in those cases, and which will not be invoked if this method is implemented. !*/
    @available(iOS 7.0, *)
    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Swift.Void) {
        waitServicesCompletion(
            { $0.application?(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: $1)},
            callbackAggregation: { results -> UIBackgroundFetchResult in
                if results.contains(.failed) {
                    return .failed
                }
                if results.contains(.noData) {
                    return .noData
                }
                return .newData
        },
            completion: completionHandler)
    }
    
    
    /// Applications with the "fetch" background mode may be given opportunities to fetch updated content in the background or when it is convenient for the system. This method will be called in these situations. You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
    @available(iOS 7.0, *)
    open func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Swift.Void) {
        for service in __services {
            service.application?(application, performFetchWithCompletionHandler: completionHandler)
        }
        waitServicesCompletion(
            {$0.application?(application, performFetchWithCompletionHandler: $1)},
            callbackAggregation: { results -> UIBackgroundFetchResult in
                if results.contains(.failed) {
                    return .failed
                }
                if results.contains(.noData) {
                    return .noData
                }
                return .newData
        },
            completion: completionHandler)
    }
    
    
    // Called when the user activates your application by selecting a shortcut on the home screen,
    // except when -application:willFinishLaunchingWithOptions: or -application:didFinishLaunchingWithOptions returns NO.
    @available(iOS 9.0, *)
    open func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Swift.Void) {
        waitServicesCompletion(
            { $0.application?(application, performActionFor: shortcutItem, completionHandler: $1)},
            completion: completionHandler)
    }
    
    
    // Applications using an NSURLSession with a background configuration may be launched or resumed in the background in order to handle the
    // completion of tasks in that session, or to handle authentication. This method will be called with the identifier of the session needing
    // attention. Once a session has been created from a configuration object with that identifier, the session's delegate will begin receiving
    // callbacks. If such a session has already been created (if the app is being resumed, for instance), then the delegate will start receiving
    // callbacks without any action by the application. You should call the completionHandler as soon as you're finished handling the callbacks.
    @available(iOS 7.0, *)
    open func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Swift.Void) {
        waitServicesCompletion(
            { $0.application?(application, handleEventsForBackgroundURLSession: identifier, completionHandler: $1)},
            completion: completionHandler)
    }
    
    
    @available(iOS 8.2, *)
    open func application(_ application: UIApplication, handleWatchKitExtensionRequest userInfo: [AnyHashable : Any]?, reply: @escaping ([AnyHashable : Any]?) -> Swift.Void) {
        waitServicesCompletion({ $0.application?(application, handleWatchKitExtensionRequest: userInfo, reply: $1)}, callbackAggregation: { results -> [AnyHashable : Any]? in
            let totals = results.flatMap({ $0 })
            if totals.isEmpty {
                return nil
            }
            return totals.reduce([:], { (total, current) -> [AnyHashable : Any]? in
                return total?.merging(current, uniquingKeysWith: { $0 })
            })
        }, completion: reply)
    }
    
    
    @available(iOS 9.0, *)
    open func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        for service in __services {
            service.applicationShouldRequestHealthAuthorization?(application)
        }
    }
    
    
    @available(iOS 4.0, *)
    open func applicationDidEnterBackground(_ application: UIApplication) {
        for service in __services {
            service.applicationDidEnterBackground?(application)
        }
    }
    
    @available(iOS 4.0, *)
    open func applicationWillEnterForeground(_ application: UIApplication) {
        for service in __services {
            service.applicationWillEnterForeground?(application)
        }
    }
    
    
    @available(iOS 4.0, *)
    open func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        for service in __services {
            service.applicationProtectedDataWillBecomeUnavailable?(application)
        }
    }
    
    @available(iOS 4.0, *)
    open func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        for service in __services {
            service.applicationProtectedDataDidBecomeAvailable?(application)
        }
    }
    
    
    // Applications may reject specific types of extensions based on the extension point identifier.
    // Constants representing common extension point identifiers are provided further down.
    // If unimplemented, the default behavior is to allow the extension point identifier.
    @available(iOS 8.0, *)
    open func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplicationExtensionPointIdentifier) -> Bool {
        var result = true
        for service in __services {
            if service.application?(application, shouldAllowExtensionPointIdentifier: extensionPointIdentifier) == false {
                result = false
            }
        }
        return result
    }
    
    
    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [Any], coder: NSCoder) -> UIViewController? {
        for service in __services {
            if let viewController = service.application?(application, viewControllerWithRestorationIdentifierPath: identifierComponents, coder: coder) {
                return viewController
            }
        }
        return nil
    }
    
    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        var result = true
        for service in __services {
            if service.application?(application, shouldSaveApplicationState: coder) == false {
                result = false
            }
        }
        return result
    }
    
    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        var result = true
        for service in __services {
            if service.application?(application, shouldRestoreApplicationState: coder) == false {
                result = false
            }
        }
        return result
    }
    
    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        for service in __services {
            service.application?(application, willEncodeRestorableStateWith: coder)
        }
    }
    
    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        for service in __services {
            service.application?(application, didDecodeRestorableStateWith: coder)
        }
    }
    
    
    // Called on the main thread as soon as the user indicates they want to continue an activity in your application. The NSUserActivity object may not be available instantly,
    // so use this as an opportunity to show the user that an activity will be continued shortly.
    // For each application:willContinueUserActivityWithType: invocation, you are guaranteed to get exactly one invocation of application:continueUserActivity: on success,
    // or application:didFailToContinueUserActivityWithType:error: if an error was encountered.
    @available(iOS 8.0, *)
    open func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        var result = true
        for service in __services {
            if service.application?(application, willContinueUserActivityWithType: userActivityType) == false {
                result = false
            }
        }
        return result
    }
    
    
    // Called on the main thread after the NSUserActivity object is available. Use the data you stored in the NSUserActivity object to re-create what the user was doing.
    // You can create/fetch any restorable objects associated with the user activity, and pass them to the restorationHandler. They will then have the UIResponder restoreUserActivityState: method
    // invoked with the user activity. Invoking the restorationHandler is optional. It may be copied and invoked later, and it will bounce to the main thread to complete its work and call
    // restoreUserActivityState on all objects.
    @available(iOS 8.0, *)
    open func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Swift.Void) -> Bool {
        return waitServicesCompletion({ $0.application?(application, continue: userActivity, restorationHandler: $1)}, callbackAggregation: { results -> [Any]? in
            return results.flatMap({ $0 })
        }, completion: restorationHandler, resultAggregation: { results -> Bool in
            return results.reduce(true, { $0 && $1 })
        }) ?? true
    }
    
    
    // If the user activity cannot be fetched after willContinueUserActivityWithType is called, this will be called on the main thread when implemented.
    @available(iOS 8.0, *)
    open func application(_ application: UIApplication, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        for service in __services {
            service.application?(application, didFailToContinueUserActivityWithType: userActivityType, error: error)
        }
    }
    
    
    // This is called on the main thread when a user activity managed by UIKit has been updated. You can use this as a last chance to add additional data to the userActivity.
    @available(iOS 8.0, *)
    open func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        for service in __services {
            service.application?(application, didUpdate: userActivity)
        }
    }
    
    
    // This will be called on the main thread after the user indicates they want to accept a CloudKit sharing invitation in your application.
    // You should use the CKShareMetadata object's shareURL and containerIdentifier to schedule a CKAcceptSharesOperation, then start using
    // the resulting CKShare and its associated record(s), which will appear in the CKContainer's shared database in a zone matching that of the record's owner.
    @available(iOS 10.0, *)
    open func application(_ application: UIApplication, userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShareMetadata) {
        for service in __services {
            service.application?(application, userDidAcceptCloudKitShareWith: cloudKitShareMetadata)
        }
    }
}
