# KDNativeShimmer

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

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

`KDNativeShimmer` allows you to customize the shimmer effect using the `ShimmerConfig` class. You can modify the base color, highlight color, opacity, gradient, animation duration, and more.

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

### Advanced Customization

You can fully customize the shimmer effect by setting the gradient, opacity, colors, and duration to fit your app's design.

```swift
let advancedShimmerConfig = ShimmerConfig(
    shimmerBaseColor: Color.gray,
    shimmerHighlightColor: Color.yellow.opacity(0.4),
    shimmerOpacity: 0.1,
    animationDuration: 1.0,
    shimmerGradient: Gradient(colors: [.clear, .white, .clear])
)
```

Then apply this configuration as usual:

```swift
Text("Advanced Shimmer")
    .animatePlaceholder(isLoading: .constant(true), config: advancedShimmerConfig)
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

