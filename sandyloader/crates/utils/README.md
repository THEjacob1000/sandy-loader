# Utilities

This crate provides common utility functions and structures used throughout the SandyLoader codebase.

## Purpose

- Centralize commonly used functionality
- Provide cross-cutting concerns like logging and configuration
- Implement shared data structures and algorithms
- Reduce code duplication across crates

## Key Components to Implement

- `logging.rs` - Logging utilities with Minecraft integration
- `config.rs` - Configuration file handling
- `version.rs` - Version parsing and comparison
- `path.rs` - Path utilities for game and mod directories
- `collections/` - Common collection utilities
  - `concurrent_map.rs` - Thread-safe map implementations
  - `object_pool.rs` - Generic object pooling
  - `weak_cache.rs` - Weak reference caching
- `serialization.rs` - Serialization utilities
- `math/` - Mathematical utilities
  - `vector.rs` - Vector operations
  - `noise.rs` - Noise generation
  - `interpolation.rs` - Interpolation functions

## Integration Points

- Used by all other SandyLoader components
- Provides foundation for higher-level functionality
- May interface with Java utilities through JNI bridge
- Used for performance-critical operations

## Development Notes

- Focus on performance and memory efficiency
- Consider thread safety requirements
- Establish consistent error handling patterns
- Provide thorough documentation for each utility
- Create utilities that mirror Minecraft's utility classes where appropriate
