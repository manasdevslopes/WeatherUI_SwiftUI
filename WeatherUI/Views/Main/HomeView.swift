//
//  HomeView.swift
//  WeatherUI
//
//  Created by MANAS VIJAYWARGIYA on 03/07/22.
//

import SwiftUI
import BottomSheet

enum BottomSheetPosition: CGFloat, CaseIterable {
  case top = 0.83 // 702/844
  case middle = 0.385 // 325/844
}

struct HomeView: View {
  @State var bottomSheetPosition: BottomSheetPosition = .middle
  @State var bottomSheetTranslation: CGFloat = BottomSheetPosition.middle.rawValue
  @State var hasDragged: Bool = false
  
  var bottomSheetTranslationProrated: CGFloat { // computed property
    (bottomSheetTranslation - BottomSheetPosition.middle.rawValue) / (BottomSheetPosition.top.rawValue - BottomSheetPosition.middle.rawValue)
  }
  
  var body: some View {
    NavigationView {
      GeometryReader { geo in
        let screenHeight = geo.size.height + geo.safeAreaInsets.top + geo.safeAreaInsets.bottom
        
        let imageOffset = screenHeight + 36
        
        ZStack {
            // MARK: Background Color
          backgroundColor
          
            // MARK: Background Image
          backgroundImage
            .offset(y: -bottomSheetTranslationProrated * imageOffset)
          
            // MARK: House Image
          houseImage
            .offset(y: -bottomSheetTranslationProrated * imageOffset)
          
            // MARK: Weather Display Area
          weatherDisplay
            .offset(y: -bottomSheetTranslationProrated * 46)
          
            // MARK: Bottom Sheet
          BottomSheetView(position: $bottomSheetPosition) {
              //Text(bottomSheetTranslationProrated.formatted())
          } content: {
            ForecastView(bottomSheetTranslationProrated: bottomSheetTranslationProrated)
          }
          .onBottomSheetDrag { translation in
            bottomSheetTranslation = translation / screenHeight
            withAnimation(.easeInOut) {
              if bottomSheetPosition == BottomSheetPosition.top {
                hasDragged = true
              } else {
                hasDragged = false
              }
            }
          }
          
            // MARK: Tab Bar
          tabBar
            .offset(y: bottomSheetTranslationProrated * 115)
        }
        .navigationBarHidden(true)
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView().preferredColorScheme(.dark)
  }
}

extension HomeView {
  private var backgroundColor: some View {
    Color.background.ignoresSafeArea()
  }
  
  private var backgroundImage: some View {
    Image("Background").resizable().ignoresSafeArea()
  }
  
  private var houseImage: some View {
    Image("House")
      .frame(maxHeight: .infinity, alignment: .top)
      .padding(.top, 257)
  }
  
  private var weatherDisplay: some View {
    VStack(
      spacing: -10 * (1 - bottomSheetTranslationProrated)
    ) {
      Text("Montreal").font(.largeTitle)
      
      VStack {
        Text(attributedString)
        
        Text("H:24°   L:18°")
          .font(.title3.weight(.semibold))
          .opacity(1 - bottomSheetTranslationProrated)
      }
      
      Spacer()
    }
    .padding(.top, 51)
  }
  
  private var tabBar: some View {
      // MARK: Tab Bar
    TabBar(action: {
      HapticManager.instance.notification(type: .success)
      HapticManager.instance.impact(style: .soft)
      bottomSheetPosition = .top
    })
  }
  
  private var attributedString: AttributedString {
    var string = AttributedString("19°" + (hasDragged ? " | " : "\n ") + "Mostly Clear") // for degree symbol use - shift + option + 8
    
    if let temp = string.range(of: "19°") {
      string[temp].font = .system(size: (96 - (bottomSheetTranslationProrated * (96 - 20))), weight: hasDragged ? .semibold : .thin)
      string[temp].foregroundColor = hasDragged ? .secondary : .primary
    }
    
    if let pipe = string.range(of: " | ") {
      string[pipe].font = .title3.weight(.semibold)
      string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranslationProrated)
    }
    
    if let weather = string.range(of: "Mostly Clear") {
      string[weather].font = .title3.weight(.semibold)
      string[weather].foregroundColor = .secondary
    }
    
    return string
  }
}
