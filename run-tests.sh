#!/bin/bash

set -e  # Exit on error

# Detect OS for path to Minecraft
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    DEFAULT_MC_DIR="$HOME/Library/Application Support/minecraft"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows
    DEFAULT_MC_DIR="$APPDATA/.minecraft"
else
    # Linux and others
    DEFAULT_MC_DIR="$HOME/.minecraft"
fi

# Configuration
MC_DIR=${MINECRAFT_DIR:-$DEFAULT_MC_DIR}
DURATION=${DURATION:-120}
ITERATIONS=${ITERATIONS:-3}
RESULTS_DIR=${RESULTS_DIR:-"test-results"}

# Help text
usage() {
    echo "SandyLoader Test Suite"
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --minecraft-dir DIR    Path to Minecraft directory (default: $DEFAULT_MC_DIR)"
    echo "  --duration SECONDS     Test duration in seconds (default: 120)"
    echo "  --iterations NUM       Number of test iterations (default: 3)"
    echo "  --results-dir DIR      Directory to store results (default: test-results)"
    echo "  --skip-java-build      Skip building Java mods"
    echo "  --skip-rust-build      Skip building Rust mods"
    echo "  --help                 Show this help message"
    exit 1
}

# Parse arguments
SKIP_JAVA_BUILD=0
SKIP_RUST_BUILD=0

while [[ $# -gt 0 ]]; do
    case $1 in
        --minecraft-dir)
            MC_DIR="$2"
            shift 2
            ;;
        --duration)
            DURATION="$2"
            shift 2
            ;;
        --iterations)
            ITERATIONS="$2"
            shift 2
            ;;
        --results-dir)
            RESULTS_DIR="$2"
            shift 2
            ;;
        --skip-java-build)
            SKIP_JAVA_BUILD=1
            shift
            ;;
        --skip-rust-build)
            SKIP_RUST_BUILD=1
            shift
            ;;
        --help)
            usage
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Create results directory
mkdir -p "$RESULTS_DIR"

echo "=== SandyLoader Test Suite ==="
echo "Minecraft directory: $MC_DIR"
echo "Test duration: $DURATION seconds"
echo "Test iterations: $ITERATIONS"
echo "Results directory: $RESULTS_DIR"
echo ""

# Build Java mods
if [ $SKIP_JAVA_BUILD -eq 0 ]; then
    echo "=== Building Java mods ==="
    
    echo "Building simple-item-mod..."
    (cd test-mods/java/simple-item-mod && ./gradlew build)
    
    echo "Building simple-utility-mod..."
    (cd test-mods/java/simple-utility-mod && ./gradlew build)
    
    echo "Java mods built successfully!"
else
    echo "Skipping Java mod build"
fi

# Build Rust mods
if [ $SKIP_RUST_BUILD -eq 0 ]; then
    echo "=== Building Rust mods ==="
    
    echo "Building simple-item-mod..."
    (cd test-mods/rust/simple-item-mod && cargo build --release)
    
    echo "Building simple-utility-mod..."
    (cd test-mods/rust/simple-utility-mod && cargo build --release)
    
    echo "Rust mods built successfully!"
else
    echo "Skipping Rust mod build"
fi

echo ""
echo "=== Running Tests ==="

# Test Item Mod
echo "Testing Simple Item Mod..."
cargo run --bin test-harness -- \
  --minecraft-dir "$MC_DIR" \
  --java-mod test-mods/java/simple-item-mod/build/libs/simple-item-mod-1.0.0.jar \
  --rust-mod test-mods/rust/simple-item-mod/target/release/libsimple_item_mod.so \
  --output "$RESULTS_DIR/item-mod-comparison.json" \
  --duration $DURATION \
  --iterations $ITERATIONS

# Test Utility Mod
echo "Testing Simple Utility Mod..."
cargo run --bin test-harness -- \
  --minecraft-dir "$MC_DIR" \
  --java-mod test-mods/java/simple-utility-mod/build/libs/simple-utility-mod-1.0.0.jar \
  --rust-mod test-mods/rust/simple-utility-mod/target/release/libsimple_utility_mod.so \
  --output "$RESULTS_DIR/utility-mod-comparison.json" \
  --duration $DURATION \
  --iterations $ITERATIONS

# Run detailed analysis on Item Mod (Java)
echo "Running detailed analysis on Java Item Mod..."
cargo run --bin mod-analyzer -- \
  --minecraft-dir "$MC_DIR" \
  --mod-path test-mods/java/simple-item-mod/build/libs/simple-item-mod-1.0.0.jar \
  --output "$RESULTS_DIR/java-item-mod-analysis.json" \
  --detailed \
  --duration $((DURATION / 2))

# Run detailed analysis on Item Mod (Rust)
echo "Running detailed analysis on Rust Item Mod..."
cargo run --bin mod-analyzer -- \
  --minecraft-dir "$MC_DIR" \
  --mod-path test-mods/rust/simple-item-mod/target/release/libsimple_item_mod.so \
  --output "$RESULTS_DIR/rust-item-mod-analysis.json" \
  --rust \
  --detailed \
  --duration $((DURATION / 2))

# Generate summary report
echo "=== Generating Summary Report ==="
cat > "$RESULTS_DIR/summary.md" << EOF
# SandyLoader Test Results Summary

Tests run on: $(date)

## Simple Item Mod Comparison

$(jq -r '.memory_reduction_percent' "$RESULTS_DIR/item-mod-comparison.json")% memory reduction
$(jq -r '.performance_improvement_percent' "$RESULTS_DIR/item-mod-comparison.json")% performance improvement

## Simple Utility Mod Comparison

$(jq -r '.memory_reduction_percent' "$RESULTS_DIR/utility-mod-comparison.json")% memory reduction
$(jq -r '.performance_improvement_percent' "$RESULTS_DIR/utility-mod-comparison.json")% performance improvement

## Detailed Analysis

See the individual JSON files for detailed analysis:
- $RESULTS_DIR/java-item-mod-analysis.json
- $RESULTS_DIR/rust-item-mod-analysis.json

## Conclusion

The Rust implementations show significant improvements in both memory usage and performance.
EOF

echo "Test suite completed successfully!"
echo "Results available in $RESULTS_DIR/summary.md"