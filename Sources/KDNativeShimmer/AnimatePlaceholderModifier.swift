//
//  AnimatePlaceholderModifier.swift
//  KDNativeShimmer
//
//  Created by KavinduDissanayake on 2024-09-07.
//  All rights reserved for KDmobileApps.
//
import SwiftUI

// MARK: - AnimatePlaceholderModifier

/// Modifier to apply a shimmering effect to views while loading.
public struct AnimatePlaceholderModifier: AnimatableModifier {
    
    @Binding var isLoading: Bool
    @State private var isAnim: Bool = false
    private var center = (UIScreen.main.bounds.width / 2) + 110
    private let animation: Animation = .linear(duration: 1.5)

    // Customizable colors and opacity
    public var shimmerBaseColor: Color
    public var shimmerHighlightColor: Color
    public var shimmerOpacity: Double

    // Custom initializer
    public init(isLoading: Binding<Bool>, shimmerBaseColor: Color = Color.gray, shimmerHighlightColor: Color = Color.white.opacity(0.48), shimmerOpacity: Double = 0.09) {
        self._isLoading = isLoading
        self.shimmerBaseColor = shimmerBaseColor
        self.shimmerHighlightColor = shimmerHighlightColor
        self.shimmerOpacity = shimmerOpacity
    }

    public func body(content: Content) -> some View {
        content.overlay(animView.mask(content))
    }

    // Shimmer view with custom colors
    private var animView: some View {
        ZStack {
            shimmerBaseColor.opacity(isLoading ? shimmerOpacity : 0.0)
            Color.white.mask(
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.clear, shimmerHighlightColor, .clear]), startPoint: .top, endPoint: .bottom)
                    )
                    .scaleEffect(1.5)
                    .rotationEffect(.init(degrees: 70.0))
                    .offset(x: isAnim ? center : -center)
            )
        }
        .animation(isLoading ? animation.repeatForever(autoreverses: false) : nil, value: isAnim)
        .onAppear {
            guard isLoading else { return }
            isAnim.toggle()
        }
        .onChange(of: isLoading) { _ in
            isAnim.toggle()
        }
    }
}

// MARK: - View Extension

public extension View {
    func animatePlaceholder(isLoading: Binding<Bool>, shimmerBaseColor: Color = Color.gray, shimmerHighlightColor: Color = Color.white.opacity(0.48), shimmerOpacity: Double = 0.09) -> some View {
        self.modifier(AnimatePlaceholderModifier(isLoading: isLoading, shimmerBaseColor: shimmerBaseColor, shimmerHighlightColor: shimmerHighlightColor, shimmerOpacity: shimmerOpacity))
    }
}
