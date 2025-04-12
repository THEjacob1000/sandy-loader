# Bytecode Transformation System

This crate provides the bytecode transformation capabilities for SandyLoader, allowing runtime modification of Minecraft classes.

## Purpose

- Intercept Java class loading to modify bytecode
- Register and manage bytecode transformers
- Apply transformations in a controlled, prioritized manner
- Support both Rust and Java-defined transformers

## Key Components to Implement

- `transformer.rs` - Core trait definitions for bytecode transformers
- `registry.rs` - Registration and management of transformers
- `asm_bridge.rs` - Integration with ASM for bytecode manipulation
- `method_redirector.rs` - Implementation of method call redirection (similar to NeoForged's MethodRedirector)
- `field_transformer.rs` - Implementation of field access transformation
- `class_injector.rs` - Support for injecting new classes

## Integration Points

- Must interface with the JNI bridge for Java integration
- Should support transformer priorities and voting
- Needs to provide a clear API for mod-provided transformers
- Must handle transformer conflicts gracefully

## Development Notes

- Consider providing both pure-Rust and JNI-based implementations
- Performance is critical here - caching and efficient bytecode processing
- Need robust error handling to prevent breaking game functionality
- May require direct FFI to ASM for complex transformations
