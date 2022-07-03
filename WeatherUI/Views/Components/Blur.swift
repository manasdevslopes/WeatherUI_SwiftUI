//
//  Blur.swift
//  WeatherUI
//
//  Created by MANAS VIJAYWARGIYA on 03/07/22.
//

import SwiftUI

class UIBackdropView: UIView {
  override class var layerClass: AnyClass {
    NSClassFromString("CABackdropLayer") ?? CALayer.self
  }
}

struct Backdrop: UIViewRepresentable {
  public init() {}
  
  public func makeUIView(context: Context) -> UIBackdropView {
    UIBackdropView()
  }
  
  public func updateUIView(_ uiView: UIBackdropView, context: Context) {}
}

struct Blur: View {
  var radius: CGFloat
  var opaque: Bool
  
  init(radius: CGFloat = 3.0, opaque: Bool = false) {
    self.radius = radius
    self.opaque = opaque
  }
  
  var body: some View {
    Backdrop().blur(radius: radius, opaque: opaque)
  }
}

struct Blur_Previews: PreviewProvider {
  static var previews: some View {
    Blur()
  }
}
