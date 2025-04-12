# SandyLoader Examples

This directory contains example mods and implementation guides for SandyLoader, demonstrating best practices and common mod patterns.

## Purpose

- Provide working examples of SandyLoader mods
- Demonstrate API usage and best practices
- Show memory optimization techniques
- Guide developers in Rust-based mod development

## Key Components to Implement

- `simple_mod/` - Basic mod example
  - `lib.rs` - Simple mod implementation
  - `README.md` - Documentation and explanation
- `block_mod/` - Example of adding blocks
  - `lib.rs` - Block implementation
  - `README.md` - Block API explanation
- `item_mod/` - Example of adding items
- `entity_mod/` - Example of custom entities
- `optimization_mod/` - Memory optimization examples
  - `lib.rs` - Memory optimization techniques
  - `README.md` - Explanation of optimizations
- `hybrid_mod/` - Example of hybrid Java/Rust mod
  - `lib.rs` - Rust implementation
  - `java/` - Java components
  - `README.md` - Integration explanation

## Integration Points

- Uses mod API for implementation
- Demonstrates registry system usage
- Shows event system integration
- Illustrates memory optimization techniques

## Development Notes

- Examples should be thoroughly documented
- Focus on real-world use cases
- Include performance comparisons where relevant
- Provide migration examples from Java to Rust
- Keep examples updated with API changes
