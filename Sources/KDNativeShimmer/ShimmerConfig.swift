//
//  ShimmerConfig.swift
//  KDNativeShimmer
//
//  Created by KavinduDissanayake on 2024-09-07.
//  All rights reserved for KDmobileApps.
//

import SwiftUI

public enum ShimmerDirection: CaseIterable {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
}

// MARK: - ShimmerConfig

/// A configuration class for the shimmer effect.
/// A configuration class for the shimmer effect, with options for color, opacity, animation duration, direction, delay, and redaction.
public class ShimmerConfig {
    // Customizable properties for the shimmer effect
    public var shimmerBaseColor: Color
    public var shimmerHighlightColor: Color
    public var shimmerOpacity: Double
    public var animationDuration: Double
    public var shimmerGradient: Gradient
    public var shouldRedact: Bool  // Controls whether the redacted modifier is applied
    public var shimmerDirection: ShimmerDirection
    public var shimmerDelay: Double
    public var redactionReason: RedactionReason

    // Initializer with default values
    public init(
        shimmerBaseColor: Color = .gray,
        shimmerHighlightColor: Color = .white.opacity(0.48),
        shimmerOpacity: Double = 0.09,
        animationDuration: Double = 1.5,
        shimmerGradient: Gradient = Gradient(colors: [.clear, .white.opacity(0.48), .clear]),
        shouldRedact: Bool = true,  // Default to applying redaction
        shimmerDirection: ShimmerDirection = .leftToRight,
        shimmerDelay: Double = 0.0,
        redactionReason: RedactionReason = .placeholderCircle
    ) {
        self.shimmerBaseColor = shimmerBaseColor
        self.shimmerHighlightColor = shimmerHighlightColor
        self.shimmerOpacity = shimmerOpacity
        self.animationDuration = animationDuration
        self.shimmerGradient = shimmerGradient
        self.shouldRedact = shouldRedact
        self.shimmerDirection = shimmerDirection
        self.shimmerDelay = shimmerDelay
        self.redactionReason = redactionReason
    }
}
