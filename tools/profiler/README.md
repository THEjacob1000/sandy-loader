# Minecraft Memory Profiler

A specialized memory profiling tool for Minecraft and its mods, designed to identify memory usage patterns and optimization opportunities.

## Features

- Tracks memory allocation and usage patterns in Minecraft
- Identifies memory-intensive mods
- Generates detailed memory usage reports
- Provides memory consumption visualization
- Tracks memory usage over time

## Status

This tool is currently in early development. Basic command-line functionality is implemented, but deep memory analysis features are still being developed.

## Usage

```bash
cargo run -- --minecraft-dir /path/to/minecraft --duration 300 --output profile-results.json
```

### Command-line Arguments

- `--minecraft-dir`, `-m`: Path to the Minecraft instance directory (required)
- `--duration`, `-d`: Duration of the profiling session in seconds (default: 300)
- `--output`, `-o`: Output file path for the profiling results (default: profile-results.json)

## Planned Features

- **Mod-specific Memory Analysis**: Detailed breakdown of memory usage by mod
- **Memory Leak Detection**: Identify potential memory leaks in mods
- **Object Allocation Tracking**: Track object allocation patterns
- **Heap Dump Analysis**: Analyze heap dumps for memory optimization opportunities
- **GUI Interface**: Visual representation of memory usage data
- **Real-time Monitoring**: Monitor memory usage in real-time
- **Comparative Analysis**: Compare memory usage before and after optimization

## Technical Approach

The profiler currently uses a combination of JVM monitoring tools to track memory usage. Future versions will incorporate:

1. JVM TI (Tool Interface) for deep JVM introspection
2. Custom JNI agents for detailed memory tracking
3. Bytecode instrumentation for specific class tracking
4. Machine learning for pattern recognition in memory usage

## Integration with SandyLoader

This profiler is designed to work alongside SandyLoader to:

1. Identify mods that would benefit most from Rust optimization
2. Provide baseline metrics for before/after comparison
3. Validate memory optimization results
4. Guide the optimization process with data-driven insights

## Contributing

Contributions to the profiler are welcome! See the [Contributing Guide](../../CONTRIBUTING.md) for more information.
