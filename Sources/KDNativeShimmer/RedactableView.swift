//
//  RedactableView.swift
//  KDNativeShimmer
//
//  Created by KavinduDissanayake on 2024-09-07.
//  All rights reserved for KDmobileApps.
//

import SwiftUI

// MARK: - RedactionReason

/// Reasons for redacting parts of the view.
public enum RedactionReason {
    case placeholder
    case placeholderCircle
    case confidential
    case blurred
}

// MARK: Step 2: Define Modifiers
struct Placeholder: ViewModifier {
  @ViewBuilder
  func body(content: Content) -> some View {
    if #available(iOS 14.0, *) {
      content.redacted(reason: RedactionReasons.placeholder)
    } else {
      content
        .accessibility(label: Text("Placeholder"))
        .opacity(0)
        .overlay(
          RoundedRectangle(cornerRadius: 2)
            .fill(Color.black.opacity(0.1))
            .padding(.vertical, 4.5)
        )
    }
  }
}

struct PlaceholderCircle: ViewModifier {
  @ViewBuilder
  func body(content: Content) -> some View {
    if #available(iOS 14.0, *) {
      content.redacted(reason: RedactionReasons.placeholder)
    } else {
      content
        .accessibility(label: Text("Placeholder"))
        .opacity(0)
        .overlay(
            Circle()
            .fill(Color.black.opacity(0.1))
            .padding(.vertical, 4.5)
        )
    }
  }
}

struct Confidential: ViewModifier {
  func body(content: Content) -> some View {
    content
      .accessibility(label: Text("Confidential"))
      .opacity(0)
      .overlay(
        RoundedRectangle(cornerRadius: 2)
          .fill(Color.black.opacity(1))
          .padding(.vertical, 4.5)
    )
  }
}

struct Blurred: ViewModifier {
  func body(content: Content) -> some View {
    content
      .accessibility(label: Text("Blurred"))
      .blur(radius: 4)
  }
}

// MARK: Step 3: Define RedactableView
struct RedactableView: ViewModifier {
  let reason: RedactionReason?

  @ViewBuilder
  func body(content: Content) -> some View {
    switch reason {
    case .placeholder:
      content
        .modifier(Placeholder())
    case .placeholderCircle:
      content
        .modifier(PlaceholderCircle())
    case .confidential:
      content
        .modifier(Confidential())
    case .blurred:
      content
        .modifier(Blurred())
    case nil:
      content
    }
  }
}

// MARK: Step 4: Define View Extension
extension View {
  func redacted(reason: RedactionReason?) -> some View {
      self
        .modifier(RedactableView(reason: reason))
  }
}

