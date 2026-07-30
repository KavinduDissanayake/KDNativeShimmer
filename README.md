# KDNativeShimmer

![Swift](https://img.shields.io/badge/Swift-5.5%2B-orange.svg)
![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS-lightgrey.svg)
![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)
[![Release](https://img.shields.io/github/v/tag/KavinduDissanayake/KDNativeShimmer?label=release)](https://github.com/KavinduDissanayake/KDNativeShimmer/releases)

**KDNativeShimmer** is a highly customizable, lightweight, and performance-optimized shimmer skeleton loading effect library for SwiftUI. It helps developers easily add polished, engaging loading placeholders to any view hierarchy while content is fetching, significantly improving perceived performance and app aesthetics.

---

## Features

*   🚀 **Performance-Optimized Rendering** — Uses core SwiftUI animation loops for smooth transitions with zero main-thread lag.
*   🎨 **Full Color & Gradient Customization** — Modify the base background color, highlight color, opacity, gradient layout, and animation durations.
*   🔄 **Flexible Directional Sweeps** — Animate shim sweeps in four directions: `.leftToRight`, `.rightToLeft`, `.topToBottom`, and `.bottomToTop`.
*   🎭 **Native Content Redactions** — Built-in masking overlays that match SwiftUI's redaction logic (`.placeholder`, `.placeholderCircle`, `.confidential`, `.blurred`).
*   ⏱ **Configurable Loop Delays** — Set a precise pause duration between animation loops to create sophisticated, staggered layout sweeps.

---

## Requirements

| Metric | Target |
|---|---|
| **iOS** | 15.0+ |
| **macOS** | 12.0+ |
| **Xcode** | 12.0+ |
| **Swift** | 5.5+ |

---

## Installation

### Xcode Integration
1. Go to `File` > `Add Packages...`
2. Enter the repository URL: `https://github.com/KavinduDissanayake/KDNativeShimmer`
3. Select your version rules (recommended version: `1.2.0` or higher).

### Package.swift
Add `KDNativeShimmer` as a dependency inside your project's `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/KavinduDissanayake/KDNativeShimmer", from: "1.2.0")
]
```

---

## Usage

### 1. Basic Usage
Import the package and use the `.animatePlaceholder(isLoading:)` modifier directly on any SwiftUI view:

```swift
import SwiftUI
import KDNativeShimmer

struct LoadingView: View {
    @State private var isFetching = true

    var body: some View {
        VStack(spacing: 16) {
            Text("Loading user profile...")
                .animatePlaceholder(isLoading: $isFetching)
                .frame(height: 20)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
                .frame(height: 120)
                .animatePlaceholder(isLoading: $isFetching)
        }
        .padding()
    }
}
```

### 2. Custom Configuration
You can customize the animation duration, delay, direction, colors, and masking using `ShimmerConfig`:

```swift
let customConfig = ShimmerConfig(
    shimmerBaseColor: Color.blue.opacity(0.1),
    shimmerHighlightColor: Color.white.opacity(0.6),
    shimmerOpacity: 0.2,
    animationDuration: 1.8,
    shimmerDirection: .topToBottom,
    shimmerDelay: 0.8,
    shouldRedact: true,
    redactionReason: .blurred
)

// Applying custom settings to your views
Text("Fetching data...")
    .animatePlaceholder(isLoading: .constant(true), config: customConfig)
```

---

## Configuration Properties

| Property | Type | Default | Description |
|---|---|---|---|
| `shimmerBaseColor` | `Color` | `.gray` | The base background color of the shimmer skeleton block. |
| `shimmerHighlightColor` | `Color` | `.white.opacity(0.48)` | The highlight gradient tint color. |
| `shimmerOpacity` | `Double` | `0.09` | The opacity of the base background layer. |
| `animationDuration` | `Double` | `1.5` | Duration of one shimmer cycle in seconds. |
| `shimmerGradient` | `Gradient` | Linear clear-white-clear | The gradient pattern of the moving highlight. |
| `shouldRedact` | `Bool` | `true` | Apply content masking and redaction to the host view. |
| `shimmerDirection` | `ShimmerDirection` | `.leftToRight` | Shimmer movement direction (`.leftToRight`, `.rightToLeft`, `.topToBottom`, `.bottomToTop`). |
| `shimmerDelay` | `Double` | `0.0` | Pause duration in seconds between animation loops. |
| `redactionReason` | `RedactionReason` | `.placeholderCircle` | Type of content redaction (`.placeholder`, `.placeholderCircle`, `.confidential`, `.blurred`). |

---

## Preview

<p align="center">
  <img src="https://raw.githubusercontent.com/KavinduDissanayake/KDNativeShimmer/main/Sources/Ss/ss.png" width="480" alt="KDNativeShimmer Loading Effect Demo" />
</p>

---

## License

Released under the MIT License. See [LICENSE](LICENSE) for details.

Copyright (c) 2026 Kavindu Dissanayake.
