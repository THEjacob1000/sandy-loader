# JNI Bridge

This crate provides comprehensive Java Native Interface (JNI) functionality for SandyLoader, enabling communication between Rust and Java components.

## Purpose

- Facilitate seamless interaction between Rust and Java code
- Manage memory safety across language boundaries
- Provide efficient data conversion between Java and Rust types
- Handle object lifecycles and garbage collection concerns

## Key Components to Implement

- `java_class.rs` - Utilities for working with Java classes
- `java_method.rs` - Method invocation helpers
- `java_field.rs` - Field access utilities
- `object_conversion.rs` - Conversion between Java and Rust objects
- `memory_management.rs` - Cross-language memory management
- `error_handling.rs` - JNI error propagation and handling
- `callback_registry.rs` - Registration of Rust callbacks for Java

## Integration Points

- Core dependency for all Java-interacting components
- Used by bytecode system for class transformation
- Utilized by event system for cross-language event dispatch
- Critical for registry system to register game objects

## Development Notes

- Performance critical - minimize JNI overhead where possible
- Consider using global references judiciously to avoid memory leaks
- Thread safety is essential for JVM interactions
- Error propagation must be robust to prevent crashes
- Heavy use of unsafe code requires thorough testing
