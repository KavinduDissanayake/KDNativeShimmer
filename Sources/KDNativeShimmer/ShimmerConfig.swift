//
//  ShimmerConfig.swift
//  KDNativeShimmer
//
//  Created by KavinduDissanayake on 2024-09-07.
//  All rights reserved for KDmobileApps.
//

import SwiftUI

// MARK: - ShimmerConfig

/// A configuration class for the shimmer effect, with options for color, opacity, animation duration, and redaction.
public class ShimmerConfig {
    // Customizable properties for the shimmer effect
    public var shimmerBaseColor: Color
    public var shimmerHighlightColor: Color
    public var shimmerOpacity: Double
    public var animationDuration: Double
    public var shimmerGradient: Gradient
    public var shouldRedact: Bool  // Controls whether the redacted modifier is applied
    public var redactionReason: RedactionReason?  // Allows user to customize redaction type

    // Initializer with default values
    public init(
        shimmerBaseColor: Color = .gray,
        shimmerHighlightColor: Color = .white.opacity(0.48),
        shimmerOpacity: Double = 0.09,
        animationDuration: Double = 1.5,
        shimmerGradient: Gradient = Gradient(colors: [.clear, .white.opacity(0.48), .clear]),
        shouldRedact: Bool = true,  // Default to applying redaction
        redactionReason: RedactionReason? = .placeholderCircle  // Default redaction reason
    ) {
        self.shimmerBaseColor = shimmerBaseColor
        self.shimmerHighlightColor = shimmerHighlightColor
        self.shimmerOpacity = shimmerOpacity
        self.animationDuration = animationDuration
        self.shimmerGradient = shimmerGradient
        self.shouldRedact = shouldRedact
        self.redactionReason = redactionReason
    }
}
