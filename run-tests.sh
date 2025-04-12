#!/bin/bash
# SandyLoader Test Suite
# A comprehensive test runner for SandyLoader mods

set -e  # Exit on error

# Default settings
MINECRAFT_DIR="$HOME/Library/Application Support/minecraft"
TEST_DURATION=120
TEST_ITERATIONS=3
RESULTS_DIR="test-results"
VERBOSE=false
BUILD_JAVA_MODS=true
BUILD_RUST_MODS=true
RUN_MEMORY_TESTS=true

# Text formatting
BOLD="\033[1m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
RESET="\033[0m"

# Print usage information
function show_help {
    echo "Usage: ./run-tests.sh [options]"
    echo ""
    echo "Options:"
    echo "  -m, --minecraft-dir DIR   Minecraft directory (default: $MINECRAFT_DIR)"
    echo "  -d, --duration SECONDS    Test duration in seconds (default: $TEST_DURATION)"
    echo "  -i, --iterations NUM      Number of test iterations (default: $TEST_ITERATIONS)"
    echo "  -o, --output-dir DIR      Results directory (default: $RESULTS_DIR)"
    echo "  -v, --verbose             Enable verbose output"
    echo "  --skip-java               Skip Java mod building and testing"
    echo "  --skip-rust               Skip Rust mod building and testing"
    echo "  --skip-memory             Skip memory profiling tests"
    echo "  -h, --help                Show this help message"
    echo ""
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -m|--minecraft-dir)
            MINECRAFT_DIR="$2"
            shift 2
            ;;
        -d|--duration)
            TEST_DURATION="$2"
            shift 2
            ;;
        -i|--iterations)
            TEST_ITERATIONS="$2"
            shift 2
            ;;
        -o|--output-dir)
            RESULTS_DIR="$2"
            shift 2
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        --skip-java)
            BUILD_JAVA_MODS=false
            shift
            ;;
        --skip-rust)
            BUILD_RUST_MODS=false
            shift
            ;;
        --skip-memory)
            RUN_MEMORY_TESTS=false
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Print test configuration
echo -e "${BOLD}=== SandyLoader Test Suite ===${RESET}"
echo "Minecraft directory: $MINECRAFT_DIR"
echo "Test duration: $TEST_DURATION seconds"
echo "Test iterations: $TEST_ITERATIONS"
echo "Results directory: $RESULTS_DIR"

# Create results directory
mkdir -p "$RESULTS_DIR"

# Function to run tests for a Java mod
function test_java_mod {
    local MOD_NAME=$1
    local MOD_DIR="test-mods/java/$MOD_NAME"
    
    echo -e "\n${BOLD}Testing Java mod: ${YELLOW}$MOD_NAME${RESET}"
    
    # Check if the mod directory exists
    if [ ! -d "$MOD_DIR" ]; then
        echo -e "${RED}Error: Mod directory not found: $MOD_DIR${RESET}"
        return 1
    fi
    
    # Check if gradlew exists
    if [ ! -f "$MOD_DIR/gradlew" ]; then
        echo -e "${YELLOW}Warning: Gradle wrapper not found in $MOD_DIR${RESET}"
        echo "Initializing Gradle wrapper..."
        
        # Check if we have gradle installed globally
        if command -v gradle &> /dev/null; then
            (cd "$MOD_DIR" && gradle wrapper)
        else
            echo -e "${RED}Error: Gradle not found. Please install Gradle or create a wrapper manually.${RESET}"
            return 1
        fi
    fi
    
    # Make gradlew executable
    chmod +x "$MOD_DIR/gradlew"
    
    # Build the mod
    echo "Building $MOD_NAME..."
    (cd "$MOD_DIR" && ./gradlew build)
    
    # Run tests
    echo "Running tests for $MOD_NAME..."
    (cd "$MOD_DIR" && ./gradlew test)
    
    # Copy test results
    mkdir -p "$RESULTS_DIR/$MOD_NAME"
    find "$MOD_DIR/build/reports" -type f -name "*.html" -o -name "*.xml" | while read file; do
        cp "$file" "$RESULTS_DIR/$MOD_NAME/"
    done
    
    echo -e "${GREEN}✓ Java mod test completed: $MOD_NAME${RESET}"
}

# Function to run tests for a Rust mod
function test_rust_mod {
    local MOD_NAME=$1
    local MOD_DIR="test-mods/rust/$MOD_NAME"
    
    echo -e "\n${BOLD}Testing Rust mod: ${YELLOW}$MOD_NAME${RESET}"
    
    # Check if the mod directory exists
    if [ ! -d "$MOD_DIR" ]; then
        echo -e "${RED}Error: Mod directory not found: $MOD_DIR${RESET}"
        return 1
    fi
    
    # Build the mod
    echo "Building $MOD_NAME..."
    (cd "$MOD_DIR" && cargo build)
    
    # Run unit tests
    echo "Running unit tests for $MOD_NAME..."
    (cd "$MOD_DIR" && cargo test)
    
    # Run the test harness
    echo "Running test harness for $MOD_NAME..."
    
    # Build the memory test flag
    local MEMORY_FLAG=""
    if [ "$RUN_MEMORY_TESTS" = true ]; then
        MEMORY_FLAG="--memory-test"
    fi
    
    # Run the test harness
    cargo run --package test-harness -- --mod-path "$MOD_DIR" --output "$RESULTS_DIR/$MOD_NAME" --timeout "$TEST_DURATION" $MEMORY_FLAG
    
    echo -e "${GREEN}✓ Rust mod test completed: $MOD_NAME${RESET}"
}

# Discover and test Java mods
if [ "$BUILD_JAVA_MODS" = true ]; then
    echo -e "\n${BOLD}=== Building Java mods ===${RESET}"
    
    # Check if test-mods/java directory exists
    if [ ! -d "test-mods/java" ]; then
        echo -e "${YELLOW}Warning: No Java mods directory found. Creating test-mods/java...${RESET}"
        mkdir -p "test-mods/java"
    fi
    
    # Get all mod directories
    JAVA_MODS=$(find "test-mods/java" -maxdepth 1 -type d -not -path "test-mods/java")
    
    if [ -z "$JAVA_MODS" ]; then
        echo "No Java mods found in test-mods/java/"
    else
        for MOD_DIR in $JAVA_MODS; do
            MOD_NAME=$(basename "$MOD_DIR")
            test_java_mod "$MOD_NAME" || echo -e "${RED}Failed to test $MOD_NAME${RESET}"
        done
    fi
fi

# Discover and test Rust mods
if [ "$BUILD_RUST_MODS" = true ]; then
    echo -e "\n${BOLD}=== Building Rust mods ===${RESET}"
    
    # Check if test-mods/rust directory exists
    if [ ! -d "test-mods/rust" ]; then
        echo -e "${YELLOW}Warning: No Rust mods directory found. Creating test-mods/rust...${RESET}"
        mkdir -p "test-mods/rust"
    fi
    
    # Get all mod directories
    RUST_MODS=$(find "test-mods/rust" -maxdepth 1 -type d -not -path "test-mods/rust")
    
    if [ -z "$RUST_MODS" ]; then
        echo "No Rust mods found in test-mods/rust/"
    else
        for MOD_DIR in $RUST_MODS; do
            MOD_NAME=$(basename "$MOD_DIR")
            test_rust_mod "$MOD_NAME" || echo -e "${RED}Failed to test $MOD_NAME${RESET}"
        done
    fi
fi

# Generate aggregate report
echo -e "\n${BOLD}=== Generating Test Report ===${RESET}"

# Count total tests, passed tests, and failed tests
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Combine results
echo "Combining test results..."
for RESULT_DIR in "$RESULTS_DIR"/*; do
    if [ -d "$RESULT_DIR" ]; then
        MOD_NAME=$(basename "$RESULT_DIR")
        
        # Check for test results
        if [ -f "$RESULT_DIR/test-report.json" ]; then
            # Count tests
            MOD_TOTAL=$(grep -c "\"name\":" "$RESULT_DIR/test-report.json")
            MOD_PASSED=$(grep -c "\"passed\":true" "$RESULT_DIR/test-report.json")
            MOD_FAILED=$((MOD_TOTAL - MOD_PASSED))
            
            TOTAL_TESTS=$((TOTAL_TESTS + MOD_TOTAL))
            PASSED_TESTS=$((PASSED_TESTS + MOD_PASSED))
            FAILED_TESTS=$((FAILED_TESTS + MOD_FAILED))
            
            echo "$MOD_NAME: $MOD_PASSED/$MOD_TOTAL tests passed"
        fi
    fi
done

# Print summary
echo -e "\n${BOLD}Test Summary:${RESET}"
echo "Total tests: $TOTAL_TESTS"
echo -e "Passed: ${GREEN}$PASSED_TESTS${RESET}"
if [ $FAILED_TESTS -gt 0 ]; then
    echo -e "Failed: ${RED}$FAILED_TESTS${RESET}"
else
    echo -e "Failed: ${GREEN}$FAILED_TESTS${RESET}"
fi

echo -e "\nDetailed results available in: ${BOLD}$RESULTS_DIR/${RESET}"

# Exit with error if any tests failed
if [ $FAILED_TESTS -gt 0 ]; then
    exit 1
fi

exit 0