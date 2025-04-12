# SandyLoader Installer

This directory contains the installation utilities for SandyLoader, enabling users to easily install and configure the mod loader.

## Purpose

- Provide easy installation for end users
- Support client and server installations
- Handle installation profiles for vanilla launcher
- Configure appropriate memory and JVM settings

## Key Components to Implement

- `installer.rs` - Main installer application
- `profiles.rs` - Launcher profile generation
- `server_setup.rs` - Server installation utilities
- `compatibility.rs` - Version compatibility checking
- `ui/` - User interface components
  - `cli.rs` - Command-line interface
  - `gui.rs` - Optional graphical interface
- `patching.rs` - Runtime patching utilities

## Integration Points

- Uses bootstrap components for initialization
- Leverages utils for configuration handling
- May interface with Java launcher through JNI bridge
- Must prepare environment for bytecode transformations

## Development Notes

- Should mirror NeoForged's installer capabilities
- Focus on ease of use for non-technical players
- Consider migration paths for existing NeoForged installations
- Support both standalone and multi-installation setups
- Implement version validation to prevent incompatible installations
