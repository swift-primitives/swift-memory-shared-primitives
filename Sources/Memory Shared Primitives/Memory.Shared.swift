// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-memory-primitives open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-memory-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

extension Memory {
    /// POSIX shared memory and Windows file mapping vocabulary.
    ///
    /// Provides policy-free access to shared memory primitives:
    /// - POSIX: `shm_open` / `shm_unlink`
    /// - Windows: `CreateFileMappingW` / `OpenFileMappingW`
    ///
    /// ## Concurrency
    /// Shared memory regions require explicit synchronization (mutexes, atomics)
    /// when accessed concurrently from multiple processes or threads.
    ///
    /// ## Platform Implementation
    ///
    /// Syscall implementations and types are in platform-specific packages:
    /// - POSIX: `swift-iso-9945` (`extension Memory.Shared`)
    ///   - `Memory.Shared.Access` - read/write access mode
    ///   - `Memory.Shared.Options` - O_CREAT, O_EXCL, O_TRUNC
    ///   - `Memory.Shared.open()` - POSIX shm_open() syscall
    /// - Windows: `swift-windows-standard` (`extension Memory.Shared`)
    ///   - `Memory.Shared.Access` - page protection modes
    ///   - `Memory.Shared.Options` - creation options
    ///   - `Memory.Shared.open()` - CreateFileMappingW syscall
    public enum Shared {}
}
