// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-memory-shared-primitives open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-memory-shared-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

public import Error_Primitives

extension Memory.Shared {
    /// Errors from shared memory syscalls.
    public enum Error: Swift.Error, Sendable, Equatable {
        /// shm_open failed.
        case open(Error_Primitives.Error.Code)

        /// shm_unlink failed.
        case unlink(Error_Primitives.Error.Code)

        /// Out of memory (`ENOMEM`).
        case exhausted
    }
}

// MARK: - CustomStringConvertible

extension Memory.Shared.Error: CustomStringConvertible {
    /// A human-readable description of the shared-memory failure.
    public var description: Swift.String {
        switch self {
        case .open(let code):
            return "shm_open failed: \(code)"

        case .unlink(let code):
            return "shm_unlink failed: \(code)"

        case .exhausted:
            return "out of memory"
        }
    }
}
