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
public struct AnimatePlaceholderModifier: ViewModifier {
    
    @Binding var isLoading: Bool
    @State private var isAnim: Bool = false
    private var config: ShimmerConfig

    // Custom initializer
    public init(isLoading: Binding<Bool>, config: ShimmerConfig = ShimmerConfig()) {
        self._isLoading = isLoading
        self.config = config
    }

    public func body(content: Content) -> some View {
        // Apply the shimmer effect only when loading is true
        content.overlay(
            Group {
                if isLoading {
                    GeometryReader { geometry in
                        shimmerOverlay(width: geometry.size.width, height: geometry.size.height)
                    }
                    .mask(content)
                }
            }
        )
    }

    // Shimmer view with custom configuration and geometry bounds
    @ViewBuilder
    private func shimmerOverlay(width: CGFloat, height: CGFloat) -> some View {
        let maxOffset = width + height
        let isHorizontal = config.shimmerDirection == .leftToRight || config.shimmerDirection == .rightToLeft
        
        let startX: CGFloat = {
            switch config.shimmerDirection {
            case .leftToRight: return -maxOffset
            case .rightToLeft: return maxOffset
            default: return 0
            }
        }()
        
        let endX: CGFloat = {
            switch config.shimmerDirection {
            case .leftToRight: return maxOffset
            case .rightToLeft: return -maxOffset
            default: return 0
            }
        }()
        
        let startY: CGFloat = {
            switch config.shimmerDirection {
            case .topToBottom: return -maxOffset
            case .bottomToTop: return maxOffset
            default: return 0
            }
        }()
        
        let endY: CGFloat = {
            switch config.shimmerDirection {
            case .topToBottom: return maxOffset
            case .bottomToTop: return -maxOffset
            default: return 0
            }
        }()
        
        let currentX = isAnim ? endX : startX
        let currentY = isAnim ? endY : startY
        
        ZStack {
            config.shimmerBaseColor.opacity(config.shimmerOpacity)
            Color.white.mask(
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: config.shimmerGradient,
                            startPoint: isHorizontal ? .leading : .top,
                            endPoint: isHorizontal ? .trailing : .bottom
                        )
                    )
                    .scaleEffect(1.5)
                    .rotationEffect(.init(degrees: isHorizontal ? 70.0 : 20.0))
                    .offset(x: currentX, y: currentY)
            )
        }
        .onAppear {
            startAnimationLoop()
        }
        .onChange(of: isLoading) { loading in
            if loading {
                startAnimationLoop()
            } else {
                isAnim = false
            }
        }
    }

    private func startAnimationLoop() {
        guard isLoading else { return }
        
        // Reset position without animation
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            isAnim = false
        }
        
        // Trigger animation with optional delay
        DispatchQueue.main.async {
            if config.shimmerDelay > 0 {
                withAnimation(.linear(duration: config.animationDuration)) {
                    isAnim = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + config.animationDuration + config.shimmerDelay) {
                    // Check again that we are still loading before starting next loop
                    if isLoading {
                        startAnimationLoop()
                    }
                }
            } else {
                withAnimation(
                    .linear(duration: config.animationDuration)
                    .repeatForever(autoreverses: false)
                ) {
                    isAnim = true
                }
            }
        }
    }
}

// MARK: - View Extension

public extension View {
    /// Applies a shimmering effect to the view when `isLoading` is true.
    func animatePlaceholder(isLoading: Binding<Bool>, config: ShimmerConfig = ShimmerConfig()) -> some View {
        self
            .modifier(AnimatePlaceholderModifier(isLoading: isLoading, config: config))
            .shimmerRedacted(reason: (isLoading.wrappedValue && config.shouldRedact) ? config.redactionReason : nil)
    }
}
