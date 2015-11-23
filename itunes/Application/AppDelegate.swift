//
//  AppDelegate.swift
//  itunes
//
//  Created by Martin Lloyd on 21/11/2015.
//  Copyright © 2015 Martin Lloyd. All rights reserved.
//

import UIKit
import XCGLogger

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
let log: XCGLogger = {
    // Setup XCGLogger
    let log = XCGLogger.defaultInstance()
    log.xcodeColorsEnabled = true // Or set the XcodeColors environment variable in your scheme to YES
    log.xcodeColors = [
        .Verbose: .lightGrey,
        .Debug: .darkGrey,
        .Info: .darkGreen,
        .Warning: .orange,
        .Error: XCGLogger.XcodeColor(fg: UIColor.redColor(), bg: UIColor.clearColor()), // Optionally use a UIColor
        .Severe: XCGLogger.XcodeColor(fg: (255, 255, 255), bg: (255, 0, 0)) // Optionally use RGB values directly
    ]
    
//    #if USE_NSLOG // Set via Build Settings, under Other Swift Flags
//        log.removeLogDestination(XCGLogger.constants.baseConsoleLogDestinationIdentifier)
//        log.addLogDestination(XCGNSLogDestination(owner: log, identifier: XCGLogger.constants.nslogDestinationIdentifier))
//        log.logAppDetails()
//    #else
//        let logPath: NSURL = appDelegate.cacheDirectory.URLByAppendingPathComponent("XCGLogger_Log.txt")
        log.setup(.Debug, showThreadName: true, showLogLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil)
//    #endif
    
    return log
}()

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        AppStyle.applyAppStyle()
        return true
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func applicationWillResignActive(application: UIApplication) {
        
    }

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func applicationDidEnterBackground(application: UIApplication) {
        
    }

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func applicationWillTerminate(application: UIApplication) {
        
    }
}

