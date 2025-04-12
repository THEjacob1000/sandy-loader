# Development Environment

This directory contains the development environment tooling for SandyLoader, enabling mod developers to build, test, and debug Rust-based Minecraft mods.

## Purpose

- Provide IDE integration for SandyLoader mod development
- Create run configurations for testing mods
- Support debugging of cross-language code
- Offer build system integration

## Key Components to Implement

- `run_configs/` - Run configurations for different environments
  - `client.rs` - Client-side testing environment
  - `server.rs` - Server-side testing environment
  - `data_generation.rs` - Data generation environments
- `templates/` - Project templates for new mods
- `build_system/` - Build system integration
  - `gradle_integration.rs` - Gradle plugin or integration
  - `cargo_extension.rs` - Cargo extensions for Minecraft mods
- `debugging/` - Debugging tools and utilities
  - `rust_debugger.rs` - Rust debugging support
  - `cross_language_debugger.rs` - Java/Rust integrated debugging

## Integration Points

- Uses bootstrap for launching development environments
- Leverages bytecode system for hot-reloading
- Interfaces with mod API for development tools
- May provide IDE plugins or extensions

## Development Notes

- Focus on developer experience comparable to NeoForged
- Should support both IntelliJ (for Java) and RustRover/VSCode (for Rust)
- Consider build performance for large mod projects
- Enable hot-reloading where possible
- Provide detailed error messages for common development issues
