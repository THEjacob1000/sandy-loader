# Mod API for SandyLoader

The official API for developing memory-efficient Minecraft mods in Rust with SandyLoader.

## Overview

The Mod API crate provides the foundation for creating Rust-based Minecraft mods that can be loaded by SandyLoader. It defines the interfaces, traits, and utilities needed for mods to interact with Minecraft's systems while taking advantage of Rust's performance and memory safety benefits.

## Features

- Comprehensive trait definitions for Rust-based mods
- Minecraft entity, block, and item interactions
- Event handling system
- Configuration management
- Resource loading utilities
- World and dimension access
- Player interaction
- Networking capabilities

## Getting Started

### Creating a Basic Mod

```rust
use mod_api::{SandyMod, ModInfo, sandy_mod};

struct MyMod {
    id: String,
    // Mod state goes here
}

impl MyMod {
    fn new() -> Self {
        Self {
            id: "my-awesome-mod".to_string(),
        }
    }
}

impl SandyMod for MyMod {
    fn id(&self) -> &str {
        &self.id
    }
    
    fn initialize(&mut self) -> Result<(), String> {
        println!("Initializing My Awesome Mod!");
        // Initialization code here
        Ok(())
    }
    
    fn on_load(&mut self) -> Result<(), String> {
        println!("My Awesome Mod is loading!");
        // Loading code here
        Ok(())
    }
    
    fn on_unload(&mut self) -> Result<(), String> {
        println!("My Awesome Mod is unloading!");
        // Cleanup code here
        Ok(())
    }
}

// This macro creates the necessary export functions
sandy_mod!(MyMod);
```

## Core Concepts

### Mod Lifecycle

SandyLoader mods follow a defined lifecycle:

1. **Creation**: The mod is instantiated
2. **Initialization**: Basic setup and resource allocation
3. **Loading**: Full integration with the game
4. **Running**: Normal operation during gameplay
5. **Unloading**: Cleanup and resource release

### Mod Information

Each mod provides metadata through the `ModInfo` structure:

```rust
let info = ModInfo {
    id: "my-mod".to_string(),
    name: "My Awesome Mod".to_string(),
    version: "1.0.0".to_string(),
    description: "This mod does awesome things!".to_string(),
};
```

## Planned API Features

The API will be expanded to include:

- **Block API**: Create and manage custom blocks
- **Item API**: Define custom items and their behaviors
- **Entity API**: Create custom entities
- **Recipe API**: Add custom crafting recipes
- **Networking API**: Send/receive network packets
- **UI API**: Create in-game user interfaces
- **Config API**: Manage mod configurations
- **Rendering API**: Custom rendering capabilities
- **World Generation API**: Modify world generation

## Current Status

The Mod API is in early development. Current work focuses on:

1. Defining the core mod traits and interfaces
2. Creating the basic mod lifecycle
3. Designing the extension mechanisms
4. Planning the additional API components

## Contributing

Contributions to the Mod API are welcome! See the [Contributing Guide](../../../CONTRIBUTING.md) for more information.
