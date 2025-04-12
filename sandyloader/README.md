# SandyLoader Core

This is the main crate for SandyLoader, a memory-efficient Minecraft mod loader using Rust and JNI.

## Overview

SandyLoader Core integrates the various components of the SandyLoader system into a cohesive mod loader that can be used alongside traditional Java mod loaders like Forge and Fabric. It handles the loading, initialization, and lifecycle management of Rust-based mods in the Minecraft environment.

## Features

- Integration with Minecraft's mod loading system
- Memory-efficient mod loading and management
- Cross-language operation between Java and Rust
- Dynamic loading and unloading of native code
- Compatibility layer with existing mod ecosystem

## Architecture

SandyLoader Core consists of several key components:

- **Mod Loader**: Handles the discovery, loading, and initialization of Rust mods
- **Memory Manager**: Manages memory allocation and optimization
- **Bridge Layer**: Facilitates communication between Java and Rust
- **Event System**: Propagates Minecraft events to Rust mods
- **Compatibility Layer**: Ensures interoperability with Java mods

## Component Crates

SandyLoader is built from several specialized crates:

- `jni-bridge`: Handles Java-Rust communication
- `memory-manager`: Provides memory optimization
- `mod-api`: Defines the API for Rust mods

## Development Status

SandyLoader Core is in the early stages of development. Current work focuses on:

1. Establishing the basic structure of the mod loader
2. Developing the JNI integration
3. Creating the memory management system
4. Designing the public API for mods

## Build and Install

```bash
# Build the library
cargo build --release

# The resulting library will be in
# target/release/libsandyloader.so (Linux)
# target/release/libsandyloader.dylib (macOS)
# target/release/sandyloader.dll (Windows)
```

## Usage

SandyLoader is intended to be used alongside a Java mod loader. Documentation for integration with Forge/Fabric will be provided as the project develops.

## Testing

```bash
# Run tests
cargo test
```

## Contributing

Contributions to SandyLoader Core are welcome! See the [Contributing Guide](../CONTRIBUTING.md) for more information.
