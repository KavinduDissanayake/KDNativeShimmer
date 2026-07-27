# KDNativeShimmer

`KDNativeShimmer` is a highly customizable shimmer effect library for iOS apps using SwiftUI. It allows you to easily add shimmering placeholders to your views while loading content, giving your app a polished and engaging loading experience.

## Requirements
* iOS 15+
* Xcode 12+
* Swift 5.5+

## Installation

### Swift Package Manager (SPM)

To integrate `KDNativeShimmer` into your project using Swift Package Manager, add the following line to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/KavinduDissanayake/KDNativeShimmer", from: "1.0.0")
]
```

Alternatively, you can add the package through Xcode:
1. Open your project in Xcode.
2. Go to `File` > `Swift Packages` > `Add Package Dependency...`
3. Enter the URL `https://github.com/KavinduDissanayake/KDNativeShimmer` and follow the instructions.

## Usage

### Basic Usage

To apply the shimmer effect to any view, follow these steps:

1. **Import `KDNativeShimmer`**:
    ```swift
    import SwiftUI
    import KDNativeShimmer
    ```

2. **Apply the shimmer effect using `animatePlaceholder`**:
    ```swift
    var body: some View {
        VStack {
            Text("Loading...")
                .animatePlaceholder(isLoading: .constant(true))
                .frame(height: 20)
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 150)
                .animatePlaceholder(isLoading: .constant(true))
        }
    }
    ```

### Customization

`KDNativeShimmer` allows you to customize the shimmer effect using the `ShimmerConfig` class. You can modify the base color, highlight color, opacity, gradient, animation duration, direction, delay, and redaction reason.

### Configuration Properties

| Property | Type | Default | Description |
|---|---|---|---|
| `shimmerBaseColor` | `Color` | `.gray` | The base background color of the shimmer block. |
| `shimmerHighlightColor` | `Color` | `.white.opacity(0.48)` | The highlight gradient tint color. |
| `shimmerOpacity` | `Double` | `0.09` | The opacity of the base background. |
| `animationDuration` | `Double` | `1.5` | Duration of one shimmer cycle in seconds. |
| `shimmerGradient` | `Gradient` | Linear clear-white-clear | The gradient pattern of the highlight. |
| `shouldRedact` | `Bool` | `true` | Apply content masking and redaction to the host view. |
| `shimmerDirection` | `ShimmerDirection` | `.leftToRight` | Shimmer movement direction (`.leftToRight`, `.rightToLeft`, `.topToBottom`, `.bottomToTop`). |
| `shimmerDelay` | `Double` | `0.0` | Pause duration in seconds between animation loops. |
| `redactionReason` | `RedactionReason` | `.placeholderCircle` | Type of content redaction (`.placeholder`, `.placeholderCircle`, `.confidential`, `.blurred`). |

### Basic Customization

1. **Create a `ShimmerConfig` object**:
    ```swift
    let shimmerConfig = ShimmerConfig(
        shimmerBaseColor: Color(hex: "#C9C9C9"),
        shimmerHighlightColor: Color.blue.opacity(0.5),
        shimmerOpacity: 0.15,
        animationDuration: 2.0
    )
    ```

2. **Apply the custom configuration to the shimmer**:
    ```swift
    var body: some View {
        VStack {
            Text("Loading custom shimmer...")
                .animatePlaceholder(isLoading: .constant(true), config: shimmerConfig)
                .frame(height: 20)
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 150)
                .animatePlaceholder(isLoading: .constant(true), config: shimmerConfig)
        }
    }
    ```

### Advanced Customization (New Features)

You can specify the movement direction, add loop delays, or toggle custom content redactions:

```swift
let customShimmerConfig = ShimmerConfig(
    shimmerDirection: .topToBottom,    // Moves from top to bottom
    shimmerDelay: 1.0,                 // Pauses for 1 second between sweeps
    shouldRedact: true,                // Redacts the original content
    redactionReason: .blurred          // Applies a blur redaction overlay
)
```

Then apply this configuration:

```swift
Text("Advanced Shimmer")
    .animatePlaceholder(isLoading: .constant(true), config: customShimmerConfig)
    .frame(height: 20)
```

### Example

Here is a full example showing how to use both default and customized shimmer effects:

```swift
import SwiftUI
import KDNativeShimmer

struct ContentView: View {
    var shimmerConfig = ShimmerConfig(
        shimmerBaseColor: Color(hex: "#C9C9C9"),
        shimmerHighlightColor: Color.blue.opacity(0.5),
        shimmerOpacity: 0.15,
        animationDuration: 2.0
    )
    
    var body: some View {
        VStack {
            // Using default shimmer effect
            Text("Default Shimmer")
                .animatePlaceholder(isLoading: .constant(true))
                .frame(height: 20)
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 150)
                .animatePlaceholder(isLoading: .constant(true))

            Spacer().frame(height: 40)
            
            // Using custom shimmer effect
            Text("Custom Shimmer")
                .animatePlaceholder(isLoading: .constant(true), config: shimmerConfig)
                .frame(height: 20)
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 150)
                .animatePlaceholder(isLoading: .constant(true), config: shimmerConfig)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

#### Cover Image
<img align="center" src="https://github.com/KavinduDissanayake/KDNativeShimmer/blob/main/Sources/Ss/ss.png">

## License

Kavindu Dissanayake

