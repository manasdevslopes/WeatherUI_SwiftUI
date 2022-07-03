//
//  NavigationBar.swift
//  WeatherUI
//
//  Created by MANAS VIJAYWARGIYA on 03/07/22.
//

import SwiftUI

struct NavigationBar: View {
  @Binding var searchText: String
  @Environment(\.dismiss) var dismiss
  
    var body: some View {
      VStack(spacing: 8) {
        HStack {
          // MARK: Back Button
          backButton
          
          Spacer()
          
          // MARK: More Button
          moreButton
        }.frame(height: 52)
        
        // MARK: Search Bar
        searchBar
      }
      .frame(height: 106, alignment: .top)
      .padding(.horizontal, 16)
      .padding(.top, 49)
      .backgroundBlur(radius: 20, opaque: true)
      .background(Color.navBarBackground)
      .frame(maxHeight: .infinity, alignment: .top)
      .ignoresSafeArea()
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
      NavigationBar(searchText: .constant(""))
    }
}

extension NavigationBar {
  private var backButton: some View {
    Button {
      HapticManager.instance.notification(type: .success)
      HapticManager.instance.impact(style: .soft)
      dismiss()
    } label: {
      HStack(spacing: 5) {
        // MARK: Back Button Icon
        Image(systemName: "chevron.left")
          .font(.system(size: 23, weight: .medium))
          .foregroundColor(.secondary)
        
        // MARK: Back Button Label
        Text("Weather").font(.title)
          .foregroundColor(.primary)
      }.frame(height: 44)
    }
  }
  
  private var moreButton: some View {
    Image(systemName: "ellipsis.circle")
      .font(.system(size: 28))
      .frame(width: 44, height: 44, alignment: .trailing)
  }
  
  private var searchBar: some View {
    HStack(spacing: 2) {
      Image(systemName: "magnifyingglass")
      TextField("Search for a city or airport", text: $searchText)
    }
    .foregroundColor(.secondary)
    .padding(.horizontal, 6)
    .padding(.vertical, 7)
    .frame(height: 36, alignment: .leading)
    .background(Color.bottomSheetBackground, in: RoundedRectangle(cornerRadius: 10))
    .innerShadow(
      shape: RoundedRectangle(cornerRadius: 10),
      color: .black.opacity(0.25),
      lineWidth: 2,
      offsetX: 0,
      offsetY: 2,
      blur: 2
    )
  }
}