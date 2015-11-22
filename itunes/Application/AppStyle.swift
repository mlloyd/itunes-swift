//
//  AppStyle.swift
//  itunes
//
//  Created by Martin Lloyd on 22/11/2015.
//  Copyright © 2015 Martin Lloyd. All rights reserved.
//

import Foundation
import UIKit

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class AppStyle {

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    class func applyAppStyle() {
        
        UINavigationBar.appearance().barTintColor        = self.gray()
        UINavigationBar.appearance().tintColor           = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        UISearchBar.appearance().barTintColor    = self.gray()
        UISearchBar.appearance().backgroundImage = UIImage()
        UISearchBar.appearance().backgroundColor = self.gray()
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
    }

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    class func gray() -> UIColor {
        return UIColor(red:0.47, green:0.53, blue:0.60, alpha:1.0);
    }
}