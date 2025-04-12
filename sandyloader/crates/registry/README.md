# Registry System

This crate implements the registry system for SandyLoader, allowing mods to register new game content such as blocks, items, entities, and more.

## Purpose

- Provide a comprehensive registration system for game objects
- Support deferred registration during appropriate initialization phases
- Handle synchronization between client and server
- Enable efficient lookups and validation

## Key Components to Implement

- `registry.rs` - Core registry implementation
- `registration_phase.rs` - Game initialization phase management
- `resource_location.rs` - ResourceLocation implementation
- `types/` - Specific registry implementations
  - `block_registry.rs` - Block registration
  - `item_registry.rs` - Item registration
  - `entity_registry.rs` - Entity type registration
  - `biome_registry.rs` - Biome registration
  - `dimension_registry.rs` - Dimension registration
- `deferred.rs` - Deferred registration support
- `validation.rs` - Registry validation utilities

## Integration Points

- Interfaces with JNI bridge to register objects with Minecraft
- Used by mod API for content registration
- Tied to event system for registration events
- Leverages memory manager for efficient storage

## Development Notes

- Must support the same registration phases as NeoForged
- Need to handle both Rust and Java-registered objects
- Consider synchronization requirements for client/server registries
- Performance is critical for object lookups during gameplay
- Must prevent duplicate registrations and ID conflicts
