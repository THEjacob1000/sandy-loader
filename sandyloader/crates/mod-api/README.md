# Mod API

This crate defines the API for creating Rust-based Minecraft mods with SandyLoader, providing interfaces for interacting with Minecraft's systems.

## Purpose

- Define the core interfaces for mod development
- Provide a comprehensive API for interacting with Minecraft
- Enable memory-efficient mod implementations
- Support both pure-Rust and hybrid Java/Rust mods

## Key Components to Implement

- `mod_trait.rs` - Core SandyMod trait definition (expanded)
- `lifecycle.rs` - Mod lifecycle management (initialize, load, unload)
- `minecraft/` - Minecraft API interfaces
  - `block.rs` - Block API
  - `item.rs` - Item API
  - `entity.rs` - Entity API
  - `world.rs` - World and dimension API
  - `player.rs` - Player interaction API
  - `network.rs` - Networking capabilities
  - `recipe.rs` - Recipe registration
  - `resource.rs` - Resource management
  - `rendering.rs` - Rendering hooks and capabilities
- `config.rs` - Configuration management
- `macro.rs` - Procedural macros for mod development

## Integration Points

- Uses registry system for game object registration
- Leverages event system for game events
- Interfaces with memory manager for optimizations
- Connects with bytecode system for hooks

## Development Notes

- Should mirror NeoForged API structure where possible for easier porting
- Focus on memory efficiency in all API designs
- Provide clear documentation and examples for each API component
- Consider compatibility layers for existing Java mods
- Develop migration tools from Java to Rust APIs
