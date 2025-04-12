# Event Bus System

This crate implements a comprehensive event system for SandyLoader, enabling communication between mods and the core game.

## Purpose

- Provide a mechanism for mods to subscribe to game events
- Support multiple event bus types (forge, mod, client, server)
- Enable event cancellation and modification
- Support event priorities and ordering

## Key Components to Implement

- `event.rs` - Core event trait and common event types
- `bus.rs` - Event bus implementation supporting registration and posting
- `listener.rs` - Listener registration and management
- `result.rs` - Event result handling
- `priority.rs` - Event priority system
- `java_bridge.rs` - Bridging to Java event system

## Integration Points

- Must support Java-defined events and listeners
- Should allow Rust mods to listen for Java events and vice versa
- Needs efficient dispatch mechanisms for high-frequency events
- Must handle cross-mod event dependencies

## Development Notes

- Consider using type-based event dispatch for efficiency
- Memory usage is important - avoid excessive allocations during event posting
- Thread safety considerations for multi-threaded event handling
- Compatibility with NeoForged's event naming and structure for easier mod porting
