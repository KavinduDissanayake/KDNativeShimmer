//
//  AnimatePlaceholderModifier.swift
//  KDNativeShimmer
//
//  Created by KavinduDissanayake on 2024-09-07.
//  All rights reserved for KDmobileApps.
//

import SwiftUI
import UIKit 

// MARK: - AnimatePlaceholderModifier

/// Modifier to apply a shimmering effect to views while loading.
public struct AnimatePlaceholderModifier: AnimatableModifier {
    
    @Binding private var isLoading: Bool
    @State private var isAnim: Bool = false
    private var center: CGFloat {
        #if os(iOS)
        return (UIScreen.main.bounds.width / 2) + 110
        #else
        return 110  // Provide a fallback for other platforms
        #endif
    }
    private let animation: Animation = .linear(duration: 1.5)
    
    // Public properties to allow customization
    public var shimmerBaseColor: Color
    public var shimmerHighlightColor: Color
    public var shimmerOpacity: Double
    
    // Public initializer for the modifier with configurable options
    public init(
        isLoading: Binding<Bool>,
        shimmerBaseColor: Color = .gray,
        shimmerHighlightColor: Color = .white.opacity(0.48),
        shimmerOpacity: Double = 0.09
    ) {
        self._isLoading = isLoading
        self.shimmerBaseColor = shimmerBaseColor
        self.shimmerHighlightColor = shimmerHighlightColor
        self.shimmerOpacity = shimmerOpacity
    }

    // The body of the modifier.
    public func body(content: Content) -> some View {
        content.overlay(isLoading ? animView.mask(content) : nil)
            .onAppear {
                guard isLoading else { return }
                isAnim.toggle()
            }
            .onReceive([isLoading].publisher.first()) { _ in
                isAnim.toggle()
            }
    }

    // This is the internal view used to animate the shimmer effect.
    private var animView: some View {
        ZStack {
            // Use the configurable color and opacity
            shimmerBaseColor.opacity(isLoading ? shimmerOpacity : 0.0)
            Color.white.mask(
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, shimmerHighlightColor, .clear]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .scaleEffect(1.5)
                    .rotationEffect(.init(degrees: 70.0))
                    .offset(x: isAnim ? center : -center)
            )
        }
        .animation(isLoading ? animation.repeatForever(autoreverses: false) : nil, value: isAnim)
    }
}

// MARK: - View Extension

/// A View extension to easily apply the shimmer effect.
public extension View {
    func animatePlaceholder(
        isLoading: Binding<Bool>,
        shimmerBaseColor: Color = .gray,
        shimmerHighlightColor: Color = .white.opacity(0.48),
        shimmerOpacity: Double = 0.09
    ) -> some View {
        self.modifier(AnimatePlaceholderModifier(
            isLoading: isLoading,
            shimmerBaseColor: shimmerBaseColor,
            shimmerHighlightColor: shimmerHighlightColor,
            shimmerOpacity: shimmerOpacity
        ))
        .redacted(reason: isLoading.wrappedValue ? .placeholderCircle : nil)
    }
}
