# Memory Shared Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

The `Memory.Shared` namespace and its typed `Error` — the shared-memory (POSIX `shm` / Windows file-mapping) vocabulary that platform packages extend with syscalls.

---

## Quick Start

`Memory.Shared` is a policy-free namespace: it owns the *vocabulary* of shared memory — what can go wrong opening or unlinking a region — while the actual `shm_open` / `shm_unlink` (POSIX) and `CreateFileMappingW` (Windows) syscalls live in downstream platform packages that extend it. The piece this package contributes to every layer above is `Memory.Shared.Error`, the typed error those wrappers throw.

```swift
import Memory_Shared_Primitives

// A downstream platform wrapper throws `Memory.Shared.Error` with typed throws:
//
//     extension Memory.Shared {
//         public static func open(...) throws(Memory.Shared.Error) -> Region
//     }
//
// Consumers handle every failure mode exhaustively, by type:

func explain(_ error: Memory.Shared.Error) -> String {
    switch error {
    case .open(let code):    return "shm_open refused the region: \(code)"
    case .unlink(let code):  return "shm_unlink refused the region: \(code)"
    case .exhausted:         return "the system is out of memory"
    }
}
```

`Memory.Shared.Error` is `Sendable` and `Equatable`, so a failure crosses actor and process boundaries unchanged and can be compared directly in tests. It is also `CustomStringConvertible`:

```swift
import Memory_Shared_Primitives

print(Memory.Shared.Error.exhausted)   // "out of memory"
```

The `.open` and `.unlink` cases each carry an `Error_Primitives.Error.Code` — the underlying platform error code (POSIX `errno` / Win32 last-error). This package re-exports `Error_Primitives` and `Memory_Primitive`, so importing `Memory Shared Primitives` brings the whole vocabulary in one import.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-memory-shared-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Memory Shared Primitives", package: "swift-memory-shared-primitives"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

Two library products. A sibling extraction of [swift-memory-primitives](https://github.com/swift-primitives/swift-memory-primitives), kept separate so the shared-memory vocabulary carries its own scope; depends only on the `Memory` and `Error` primitives.

| Product | Target | Purpose |
|---------|--------|---------|
| `Memory Shared Primitives` | `Sources/Memory Shared Primitives/` | The `Memory.Shared` namespace and `Memory.Shared.Error` (`.open`, `.unlink`, `.exhausted`); re-exports `Error_Primitives` and `Memory_Primitive`. |
| `Memory Shared Primitives Test Support` | `Tests/Support/` | Re-exports the main target for test consumers. |

Syscall implementations and their `Access` / `Options` types live in platform packages that `extension Memory.Shared` — POSIX in [swift-iso-9945](https://github.com/swift-standards/swift-iso-9945), Windows in swift-windows-standard.

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
