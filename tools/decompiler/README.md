# Minecraft Decompiler

This tool provides functionality for decompiling Minecraft, similar to NeoForged's use of NeoForm, enabling inspection and patching of Minecraft's source code.

## Purpose

- Decompile Minecraft for inspection and patching
- Generate mappings for obfuscated Minecraft names
- Provide access to readable Minecraft sources
- Support the patching process

## Key Components to Implement

- `decompiler.rs` - Main decompilation functionality
- `mapping.rs` - Mapping management for obfuscated names
- `source_processor.rs` - Post-decompilation source processing
- `validation.rs` - Validation of decompiled sources
- `cache.rs` - Caching of decompilation results

## Integration Points

- Used by patcher for generating patches
- May provide data for bytecode transformations
- Leverages JNI bridge for decompiler functionality
- Outputs feed into development environment

## Development Notes

- Consider leveraging existing tools like FFJ, Vineflower, or similar
- Performance is important for developer iteration
- Caching is essential for repeated decompilation
- Must handle Minecraft obfuscation patterns
- Should generate consistent output for reliable patching
