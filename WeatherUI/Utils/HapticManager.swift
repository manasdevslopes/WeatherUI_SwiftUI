//
//  HapticManager.swift
//  WeatherUI
//
//  Created by MANAS VIJAYWARGIYA on 03/07/22.
//

import SwiftUI

class HapticManager { // haptic singleton class
  static let instance = HapticManager()
  
  func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(type)
  }
  func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.impactOccurred()
  }
}

