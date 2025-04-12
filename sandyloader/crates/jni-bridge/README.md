# JNI Bridge for SandyLoader

A lightweight, efficient bridge between Java and Rust for the SandyLoader ecosystem.

## Overview

The JNI Bridge crate facilitates seamless communication between Java (Minecraft/JVM) and Rust (SandyLoader) components. It handles the complexities of cross-language function calls, memory management, and error handling to provide a reliable foundation for the SandyLoader architecture.

## Features

- Bi-directional function calls between Java and Rust
- Efficient data conversion between language types
- Memory-safe object handling across language boundaries
- Comprehensive error handling and reporting
- Streamlined API for cross-language development

## Technical Approach

This crate utilizes the Java Native Interface (JNI) to establish communication between the JVM and Rust code. It provides several key abstractions:

1. **Type Conversion**: Safe, efficient conversion between Java and Rust data types
2. **Method Invocation**: Mechanisms to call Java methods from Rust and vice versa
3. **Object Lifetimes**: Proper management of object references across language boundaries
4. **Error Handling**: Comprehensive error types and propagation

## Usage Examples

### Calling Java Methods from Rust

```rust
use jni_bridge::{call_java_method, Result};
use jni::objects::{JObject, JValue};
use jni::JNIEnv;

fn example_call(env: &JNIEnv, obj: &JObject) -> Result<String> {
    // Call a Java method
    let result = call_java_method(
        env,
        obj,
        "getPlayerName",
        "()Ljava/lang/String;",
        &[]
    )?;
    
    // Convert the result to a Rust String
    match result {
        JValue::Object(obj) => {
            let string = env.get_string(obj.into())?;
            Ok(string.into())
        },
        _ => Err(jni_bridge::BridgeError::ConversionError(
            "Expected string return value".to_string()
        )),
    }
}
```

### Registering Native Methods

```rust
// Example to be expanded as the implementation develops
```

## Current Status

The JNI Bridge is in early development. Current implemented features include:

- Basic method call functionality
- Error type definitions
- Initial architectural design

Upcoming work includes:

- Comprehensive type conversion utilities
- Object reference tracking
- Memory optimization strategies
- Native method registration
- Automated binding generation

## Dependencies

- `jni`: Rust bindings for the Java Native Interface
- `thiserror`: For error handling
- `log`: For logging functionality

## Contributing

Contributions to the JNI Bridge are welcome! See the [Contributing Guide](../../../CONTRIBUTING.md) for more information.
