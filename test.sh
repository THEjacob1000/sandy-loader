#!/bin/bash
set -e

# Colors for pretty output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Configuration
MINECRAFT_DIR="${MINECRAFT_DIR:-$HOME/Library/Application Support/minecraft}"
TEST_DURATION=120
TEST_ITERATIONS=3
RESULTS_DIR="test-results"

# Create results directory if it doesn't exist
mkdir -p "$RESULTS_DIR"

# Welcome message
echo -e "${BOLD}=== SandyLoader Test Suite ===${NC}"
echo "Minecraft directory: $MINECRAFT_DIR"
echo "Test duration: $TEST_DURATION seconds"
echo "Test iterations: $TEST_ITERATIONS"
echo "Results directory: $RESULTS_DIR"
echo ""

# Make the test scripts executable
chmod +x ./test-java.sh
chmod +x ./test-rust.sh

# Run the Java tests
echo -e "${BOLD}=== Java Test Results ===${NC}"
echo ""
JAVA_RESULTS=$(./test-java.sh "$MINECRAFT_DIR" "$TEST_DURATION" "$TEST_ITERATIONS" "$RESULTS_DIR")
echo "$JAVA_RESULTS"

# Extract Java test counts from output
JAVA_PASSED=$(echo "$JAVA_RESULTS" | grep -o "JAVA_PASSED=[0-9]*" | cut -d= -f2)
JAVA_FAILED=$(echo "$JAVA_RESULTS" | grep -o "JAVA_FAILED=[0-9]*" | cut -d= -f2)
JAVA_TOTAL=$(echo "$JAVA_RESULTS" | grep -o "JAVA_TOTAL=[0-9]*" | cut -d= -f2)

# Store Java failures
JAVA_FAILURES=$(echo "$JAVA_RESULTS" | awk '/BEGIN_FAILURES/,/END_FAILURES/' | grep -v "BEGIN_FAILURES\|END_FAILURES" || echo "")

# Run the Rust tests
echo -e "${BOLD}=== Rust Test Results ===${NC}"
echo ""
RUST_RESULTS=$(./test-rust.sh "$MINECRAFT_DIR" "$TEST_DURATION" "$TEST_ITERATIONS" "$RESULTS_DIR")
echo "$RUST_RESULTS"

# Extract Rust test counts from output
RUST_PASSED=$(echo "$RUST_RESULTS" | grep -o "RUST_PASSED=[0-9]*" | cut -d= -f2)
RUST_FAILED=$(echo "$RUST_RESULTS" | grep -o "RUST_FAILED=[0-9]*" | cut -d= -f2)
RUST_TOTAL=$(echo "$RUST_RESULTS" | grep -o "RUST_TOTAL=[0-9]*" | cut -d= -f2)

# Store Rust failures
RUST_FAILURES=$(echo "$RUST_RESULTS" | awk '/BEGIN_FAILURES/,/END_FAILURES/' | grep -v "BEGIN_FAILURES\|END_FAILURES" || echo "")

# Generate summary
echo -e "${BOLD}=== Test Summary ===${NC}"
TOTAL=$((JAVA_TOTAL + RUST_TOTAL))
PASSED=$((JAVA_PASSED + RUST_PASSED))
FAILED=$((JAVA_FAILED + RUST_FAILED))

echo "Total tests: $TOTAL"
echo -e "Passed: ${GREEN}${PASSED}${NC}"
echo -e "Failed: ${RED}${FAILED}${NC}"
echo ""

# Print failures if any
if [ $FAILED -gt 0 ]; then
    echo -e "${BOLD}=== Failed Tests ===${NC}"
    echo ""

    # Print Java failures
    if [ -n "$JAVA_FAILURES" ]; then
        echo "$JAVA_FAILURES"
    fi

    # Print Rust failures
    if [ -n "$RUST_FAILURES" ]; then
        echo "$RUST_FAILURES"
    fi

    exit 1
fi

exit 0
