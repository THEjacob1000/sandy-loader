# SandyLoader Testing Framework

This directory contains tools and test mods for evaluating the performance and memory efficiency of SandyLoader.

## Overview

The testing framework allows you to:

1. Compare Java and Rust implementations of the same mod
2. Analyze memory usage patterns
3. Measure performance improvements
4. Generate detailed reports for optimization

## Components

### Test Harness

The test harness (`tools/test-harness`) is a command-line tool that loads both Java and Rust mods in a controlled environment and measures their memory usage and performance.

```bash
# Example usage
cargo run --bin test-harness -- \
  --minecraft-dir path/to/minecraft \
  --java-mod test-mods/java/simple-item-mod/build/libs/simple-item-mod-1.0.0.jar \
  --rust-mod test-mods/rust/simple-item-mod/target/release/libsimple_item_mod.so \
  --output comparison-results.json \
  --duration 120 \
  --iterations 3
```

### Mod Analyzer

The mod analyzer (`tools/mod-analyzer`) provides detailed memory analysis for individual mods.

```bash
# Example usage for Java mod
cargo run --bin mod-analyzer -- \
  --minecraft-dir path/to/minecraft \
  --mod-path test-mods/java/simple-item-mod/build/libs/simple-item-mod-1.0.0.jar \
  --output java-analysis.json \
  --detailed

# Example usage for Rust mod
cargo run --bin mod-analyzer -- \
  --minecraft-dir path/to/minecraft \
  --mod-path test-mods/rust/simple-item-mod/target/release/libsimple_item_mod.so \
  --output rust-analysis.json \
  --rust \
  --detailed
```

## Test Mods

### Java Test Mods

1. **Simple Item Mod** - A basic mod that adds an item and a block to the game
   - Located in `test-mods/java/simple-item-mod/`
   - Build with Gradle: `cd test-mods/java/simple-item-mod && ./gradlew build`

2. **Simple Utility Mod** - A utility mod that provides helper functions
   - Located in `test-mods/java/simple-utility-mod/`
   - Build with Gradle: `cd test-mods/java/simple-utility-mod && ./gradlew build`

### Rust Test Mods

1. **Simple Item Mod** - Rust implementation of the item mod
   - Located in `test-mods/rust/simple-item-mod/`
   - Build with Cargo: `cd test-mods/rust/simple-item-mod && cargo build --release`

2. **Simple Utility Mod** - Rust implementation of the utility mod
   - Located in `test-mods/rust/simple-utility-mod/`
   - Build with Cargo: `cd test-mods/rust/simple-utility-mod && cargo build --release`

## Running Tests

To compare Java and Rust implementations, follow these steps:

1. Build both the Java and Rust versions of a test mod
2. Run the test harness to compare them
3. Use the mod analyzer for more detailed memory analysis
4. Review the generated reports

## Adding New Test Mods

To add a new test mod:

1. Create a Java implementation in `test-mods/java/your-mod-name/`
2. Create a matching Rust implementation in `test-mods/rust/your-mod-name/`
3. Implement identical functionality in both versions
4. Make sure to include memory-intensive operations to highlight differences

## Tips for Testing

- Run tests multiple times with the `--iterations` flag for more reliable results
- Use the `--detailed` flag with the mod analyzer for in-depth memory analysis
- Compare peak memory usage, not just average usage
- Look at memory growth rates to identify potential memory leaks
- Use the generated JSON files to create visualizations of memory usage

## Interpreting Results

When comparing Java and Rust mods, look for these key metrics:

- **Memory Usage Reduction**: How much less memory the Rust mod uses compared to Java
- **Memory Growth Rate**: How quickly memory usage increases over time
- **Peak Memory Usage**: The maximum memory used during testing
- **Allocation Patterns**: The number and size of memory allocations
- **GC Pauses**: Less frequent and shorter GC pauses indicate better performance
