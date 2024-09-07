//
//  ShimmerConfig.swift
//  KDNativeShimmer
//
//  Created by KavinduDissanayake on 2024-09-07.
//  All rights reserved for KDmobileApps.
//

import SwiftUI

// MARK: - ShimmerConfig

/// A configuration class for the shimmer effect.
public class ShimmerConfig {
    // Customizable properties for the shimmer effect
    public var shimmerBaseColor: Color
    public var shimmerHighlightColor: Color
    public var shimmerOpacity: Double
    public var animationDuration: Double
    public var shimmerGradient: Gradient

    // Initializer with default values
    public init(
        shimmerBaseColor: Color = .gray,
        shimmerHighlightColor: Color = .white.opacity(0.48),
        shimmerOpacity: Double = 0.09,
        animationDuration: Double = 1.5,
        shimmerGradient: Gradient = Gradient(colors: [.clear, .white.opacity(0.48), .clear])
    ) {
        self.shimmerBaseColor = shimmerBaseColor
        self.shimmerHighlightColor = shimmerHighlightColor
        self.shimmerOpacity = shimmerOpacity
        self.animationDuration = animationDuration
        self.shimmerGradient = shimmerGradient
    }
}
