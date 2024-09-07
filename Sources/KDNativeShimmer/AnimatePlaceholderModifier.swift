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
    private var config: ShimmerConfig

    // Custom initializer
    public init(isLoading: Binding<Bool>, config: ShimmerConfig = ShimmerConfig()) {
        self._isLoading = isLoading
        self.config = config
    }

    public func body(content: Content) -> some View {
           // Apply the shimmer effect only when loading is true, and optionally apply redaction based on configuration
           content
               .if(config.shouldRedact && config.redactionReason != nil) { view in
                   view.redacted(reason: config.redactionReason!)
               }
               .overlay(isLoading ? animView.mask(content) : nil)
       }
    // Shimmer view with custom configuration
    private var animView: some View {
        ZStack {
            config.shimmerBaseColor.opacity(isLoading ? config.shimmerOpacity : 0.0)
            Color.white.mask(
                Rectangle()
                    .fill(
                        LinearGradient(gradient: config.shimmerGradient, startPoint: .top, endPoint: .bottom)
                    )
                    .scaleEffect(1.5)
                    .rotationEffect(.init(degrees: 70.0))
                    .offset(x: isAnim ? center : -center)
            )
        }
        .animation(isLoading ? Animation.linear(duration: config.animationDuration).repeatForever(autoreverses: false) : nil, value: isAnim)
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
extension View {
    /// Conditional modifier: Applies the given modifier only when the condition is true.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, apply: (Self) -> Content) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }
}

public extension View {
    /// Applies a shimmering effect to the view when `isLoading` is true, with options for redaction.
    func animatePlaceholder(isLoading: Binding<Bool>, config: ShimmerConfig = ShimmerConfig()) -> some View {
        self.modifier(AnimatePlaceholderModifier(isLoading: isLoading, config: config))
    }
}

