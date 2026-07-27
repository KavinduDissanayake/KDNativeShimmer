import XCTest
import SwiftUI
@testable import KDNativeShimmer

final class KDNativeShimmerTests: XCTestCase {
    
    // Test that default config properties are correct and backward compatible
    func testShimmerConfigDefaultValues() {
        let config = ShimmerConfig()
        
        XCTAssertEqual(config.shimmerBaseColor, Color.gray)
        XCTAssertEqual(config.shimmerHighlightColor, Color.white.opacity(0.48))
        XCTAssertEqual(config.shimmerOpacity, 0.09)
        XCTAssertEqual(config.animationDuration, 1.5)
        XCTAssertTrue(config.shouldRedact)
        
        // Check new default options to verify backwards compatibility
        XCTAssertEqual(config.shimmerDirection, .leftToRight)
        XCTAssertEqual(config.shimmerDelay, 0.0)
        XCTAssertEqual(config.redactionReason, .placeholderCircle)
    }
    
    // Test that legacy custom initializer works perfectly without compile errors
    func testShimmerConfigLegacyInitializer() {
        let customColor = Color.red
        let customHighlight = Color.blue
        let customOpacity = 0.25
        let customDuration = 3.0
        let customGradient = Gradient(colors: [Color.red, Color.blue])
        
        let config = ShimmerConfig(
            shimmerBaseColor: customColor,
            shimmerHighlightColor: customHighlight,
            shimmerOpacity: customOpacity,
            animationDuration: customDuration,
            shimmerGradient: customGradient,
            shouldRedact: false
        )
        
        XCTAssertEqual(config.shimmerBaseColor, customColor)
        XCTAssertEqual(config.shimmerHighlightColor, customHighlight)
        XCTAssertEqual(config.shimmerOpacity, customOpacity)
        XCTAssertEqual(config.animationDuration, customDuration)
        XCTAssertEqual(config.shimmerGradient.stops.count, customGradient.stops.count)
        XCTAssertFalse(config.shouldRedact)
        
        // Ensure trailing new configurations defaults are still set correctly
        XCTAssertEqual(config.shimmerDirection, .leftToRight)
        XCTAssertEqual(config.shimmerDelay, 0.0)
        XCTAssertEqual(config.redactionReason, .placeholderCircle)
    }
    
    // Test that all new properties can be fully customized
    func testShimmerConfigNewProperties() {
        let config = ShimmerConfig(
            shimmerDirection: .topToBottom,
            shimmerDelay: 1.2,
            redactionReason: .blurred
        )
        
        XCTAssertEqual(config.shimmerDirection, .topToBottom)
        XCTAssertEqual(config.shimmerDelay, 1.2)
        XCTAssertEqual(config.redactionReason, .blurred)
    }
    
    // Test that all enum values of ShimmerDirection exist
    func testShimmerDirectionEnumCases() {
        let allCases = ShimmerDirection.allCases
        XCTAssertEqual(allCases.count, 4)
        XCTAssertTrue(allCases.contains(.leftToRight))
        XCTAssertTrue(allCases.contains(.rightToLeft))
        XCTAssertTrue(allCases.contains(.topToBottom))
        XCTAssertTrue(allCases.contains(.bottomToTop))
    }
    
    // Test custom RedactionReason enum values
    func testRedactionReasonEnumCases() {
        let reasons: [RedactionReason] = [.placeholder, .placeholderCircle, .confidential, .blurred]
        XCTAssertEqual(reasons.count, 4)
    }
}
