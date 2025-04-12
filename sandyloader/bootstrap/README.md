# SandyLoader Bootstrap

This directory contains the bootstrap launcher for SandyLoader, responsible for initializing the Java Virtual Machine and loading the core SandyLoader components.

## Purpose

- Initialize the JVM with appropriate memory and classpath settings
- Set up the class transformation system
- Inject SandyLoader into Minecraft's loading process
- Handle command-line arguments and configuration
- Bridge between Rust components and Java systems

## Key Components to Implement

- `launcher.rs` - Main entry point for launching Minecraft with SandyLoader
- `jvm_setup.rs` - JVM initialization and configuration
- `arguments.rs` - Command-line argument parsing (mirroring NeoForged's format)
- `classpath.rs` - Classpath management and mod discovery
- `config.rs` - Configuration file handling

## Integration Points

- Must be compatible with ModLauncher or provide equivalent functionality
- Should support the same command-line arguments as NeoForged
- Needs to initialize the bytecode transformation system early in the loading process
- Must set up memory management controls before heavy Minecraft initialization

## Development Notes

- Consider implementing as a standalone executable that then loads the rest of SandyLoader
- Must handle both client and server launch configurations
- Should provide debug output similar to NeoForged's verbose mode
