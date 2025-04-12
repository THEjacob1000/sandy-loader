# Java Interoperability

This directory contains Java code that interfaces with SandyLoader's Rust components, providing seamless integration with Minecraft and existing Java mods.

## Purpose

- Provide Java entry points for Rust functionality
- Create Java wrappers around Rust mod APIs
- Support existing Java mods with SandyLoader
- Bridge the Minecraft Java ecosystem with Rust implementations

## Key Components to Implement

- `com/sandyloader/` - Main package
  - `SandyLoader.java` - Main entry point and API
  - `SandyMod.java` - Java interface for Rust mods
  - `RustEventBus.java` - Java wrapper for Rust event system
  - `RustRegistry.java` - Java interface to Rust registry system
- `com/sandyloader/api/` - Public API
  - `SandyModContainer.java` - Mod container implementation
  - `RustResourceLocation.java` - ResourceLocation wrapper
  - `MemoryOptimizer.java` - Memory optimization utilities
- `com/sandyloader/compat/` - Compatibility layer
  - `ForgeCompat.java` - NeoForged compatibility
  - `FabricCompat.java` - Fabric compatibility (optional)
  - `ModLoaderCompat.java` - ModLoader integration

## Integration Points

- Critical interface between Minecraft and Rust components
- Provides compatibility layer for existing Java mods
- Exposes Rust functionality to Java code
- Handles Java event forwarding to Rust

## Development Notes

- Keep Java code minimal - prefer implementing in Rust where possible
- Focus on compatibility with existing mod APIs
- Consider performance implications of cross-language calls
- Use JNI annotations for clarity
- Implement robust error handling for cross-language errors
