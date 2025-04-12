#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Parse arguments
MINECRAFT_DIR="$1"
TEST_DURATION="$2"
TEST_ITERATIONS="$3"
RESULTS_DIR="$4"

# Track pass/fail counts
RUST_TOTAL=0
RUST_PASSED=0
RUST_FAILED=0

# Keep track of failed tests for summary
FAILED_TESTS=()

# Run cargo test from the root directory
echo "Running Rust tests..."
OUTPUT=$(cargo test 2>&1)
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
    echo -e "${RED}Cargo test failed with exit code $EXIT_CODE${NC}"
    echo -e "  ${RED}✘${NC} Compilation or test runner error"
    echo "$OUTPUT" | grep -E "error(\[E[0-9]+\])?:" | head -3
    RUST_TOTAL=1
    RUST_FAILED=1
    FAILED_TESTS+=("${RED}✘ [fail]:${NC} Cargo tests: Compilation error")

    # Output test counts
    echo ""
    echo "RUST_TOTAL=$RUST_TOTAL"
    echo "RUST_PASSED=$RUST_PASSED"
    echo "RUST_FAILED=$RUST_FAILED"
    echo "BEGIN_FAILURES"
    for FAILURE in "${FAILED_TESTS[@]}"; do
        echo "$FAILURE"
    done
    echo "END_FAILURES"
    exit 1
fi

# Extract all test lines first
TEST_LINES=$(echo "$OUTPUT" | grep -E "^test [^\.]+\.\.\. (ok|FAILED|ignored)" || echo "")
if [ -z "$TEST_LINES" ]; then
    echo "No tests found in cargo test output."

    # Check if there were actually test runs with 0 tests
    if [[ "$OUTPUT" == *"running 0 tests"* ]]; then
        echo -e "${GREEN}All crates compiled successfully, but no tests were found.${NC}"
    fi

    # Mark as success since cargo test passed
    RUST_TOTAL=0
    RUST_PASSED=0
    RUST_FAILED=0
else
    # Process all crates and tests
    CURRENT_CRATE=""
    CURRENT_DISPLAY_NAME=""

    # Process the output line by line
    while IFS= read -r line; do
        # Check if this is a line starting a new crate's tests
        if [[ $line =~ Running\ unittests.*\(target/debug/deps/([^-]+)-.+\) ]]; then
            # If we had a previous crate, add a blank line
            if [ -n "$CURRENT_CRATE" ]; then
                echo ""
            fi

            # Extract and format the crate name
            CURRENT_CRATE="${BASH_REMATCH[1]}"
            CURRENT_DISPLAY_NAME=$(echo "$CURRENT_CRATE" | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1')
            echo -e "${BOLD}${CURRENT_DISPLAY_NAME}${NC}"

        # Process test lines
        elif [[ $line =~ ^test\ ([^\.]+)\.\.\.\ (ok|FAILED|ignored) ]]; then
            # Extract test name and result
            TEST_NAME="${BASH_REMATCH[1]}"
            RESULT="${BASH_REMATCH[2]}"

            # Skip ignored tests
            if [[ "$RESULT" == "ignored" ]]; then
                continue
            fi

            # Format the test name for display
            DISPLAY_TEST=$(echo "$TEST_NAME" | sed 's/tests:://' | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1')

            # Count tests
            if [[ "$RESULT" == "ok" ]]; then
                echo -e "  ${GREEN}✓${NC} $DISPLAY_TEST"
                ((RUST_PASSED++))
                ((RUST_TOTAL++))
            else
                echo -e "  ${RED}✘${NC} $DISPLAY_TEST"
                ((RUST_FAILED++))
                ((RUST_TOTAL++))
                FAILED_TESTS+=("${RED}✘ [fail]:${NC} ${CURRENT_DISPLAY_NAME}.$TEST_NAME")
            fi
        fi
    done < <(echo "$OUTPUT")
fi

# Output test counts (for the main script to parse)
echo ""
echo "RUST_TOTAL=$RUST_TOTAL"
echo "RUST_PASSED=$RUST_PASSED"
echo "RUST_FAILED=$RUST_FAILED"

# Output failures in a format that can be parsed by the main script
if [ ${#FAILED_TESTS[@]} -gt 0 ]; then
    echo "BEGIN_FAILURES"
    for FAILURE in "${FAILED_TESTS[@]}"; do
        echo "$FAILURE"
    done
    echo "END_FAILURES"
fi

exit 0
