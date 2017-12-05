//
//  AppDelegate.swift
//  Cleverbot
//
//  Created by Suyeol Jeon on 01/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

import CGFloatLiteral
import ManualLayout
import RxOptional
import SnapKit
import SwiftyColor
import SwiftyImage
import Then
import UITextView_Placeholder

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var dependency: AppDependency!
  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    self.dependency = self.dependency ?? CompositionRoot.resolve()
    self.window = self.dependency.window
    return true
  }
}
