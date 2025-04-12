# Minecraft Patcher

This tool provides functionality for creating, applying, and managing patches to Minecraft's codebase, similar to NeoForged's patching system.

## Purpose

- Create patches from modified Minecraft sources
- Apply patches to vanilla Minecraft
- Manage patch conflicts and rejections
- Support development workflow for core modifications

## Key Components to Implement

- `patch_creator.rs` - Create patches from source differences
- `patch_applier.rs` - Apply patches to source files
- `conflict_resolver.rs` - Resolve patch conflicts
- `patch_format.rs` - Patch file format handling
- `rejection_handler.rs` - Handle and report patch rejections

## Integration Points

- Works with decompiler for accessing Minecraft sources
- Outputs applied patches for bytecode transformations
- May interface with development environment
- Supports installer for applying patches during installation

## Development Notes

- Should support unified diff format compatible with git
- Consider implementing three-way merge capability
- Performance important for large patch sets
- Error reporting critical for development workflow
- May need special handling for Minecraft version updates
