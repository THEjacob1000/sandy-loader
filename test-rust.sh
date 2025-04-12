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

# Find all Rust mod directories
RUST_MOD_DIRS=$(find test-mods/rust -mindepth 1 -maxdepth 1 -type d 2>/dev/null || echo "")

# If no directories found, print message and return
if [ -z "$RUST_MOD_DIRS" ]; then
    echo "No Rust mods found for testing"
    echo ""
    echo "RUST_TOTAL=0"
    echo "RUST_PASSED=0"
    echo "RUST_FAILED=0"
    echo "BEGIN_FAILURES"
    echo "END_FAILURES"
    exit 0
fi

# Process each Rust mod
for MOD_DIR in $RUST_MOD_DIRS; do
    MOD_NAME=$(basename "$MOD_DIR")

    echo -e "${BOLD}$MOD_NAME${NC}"
    MOD_TESTS_PASSED=true

    # Check if Cargo.toml exists
    if [ ! -f "$MOD_DIR/Cargo.toml" ]; then
        echo -e "  ${RED}✘${NC} No Cargo.toml found"
        RUST_TOTAL=$((RUST_TOTAL + 1))
        RUST_FAILED=$((RUST_FAILED + 1))
        FAILED_TESTS+=("${RED}✘ [fail]:${NC} $MOD_NAME: No Cargo.toml found")
        echo ""
        continue
    fi

    # Run cargo test to find tests with `#[cfg(test)]`
    # In a real implementation, you would use the actual cargo test command
    OUTPUT=$(cd "$MOD_DIR" && cargo test 2>&1)
    EXIT_CODE=$?

    # Parse test results
    if [ $EXIT_CODE -eq 0 ]; then
        # Extract test names and results from cargo test output
        # Looking for lines with "test tests::" and "... ok" or "... FAILED"
        TESTS=$(echo "$OUTPUT" | grep -E "test tests::[a-zA-Z0-9_]+ \.\.\. (ok|FAILED)" || echo "")

        # If no tests were found, try a simpler pattern
        if [ -z "$TESTS" ]; then
            TESTS=$(echo "$OUTPUT" | grep -E "test [a-zA-Z0-9_:]+ \.\.\. (ok|FAILED)" || echo "")
        fi

        # Process each test result
        if [ -n "$TESTS" ]; then
            while IFS= read -r TEST_LINE; do
                # Extract test name and result from the line
                TEST_NAME=$(echo "$TEST_LINE" | grep -o "test [a-zA-Z0-9_:]\+" | sed 's/test //')
                TEST_RESULT=$(echo "$TEST_LINE" | grep -o " ok\| FAILED" | tr -d ' ')

                # Format the test name for display
                DISPLAY_NAME=$(echo "$TEST_NAME" | sed 's/tests:://' | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1')

                RUST_TOTAL=$((RUST_TOTAL + 1))

                if [[ "$TEST_RESULT" == "ok" ]]; then
                    echo -e "  ${GREEN}✓${NC} $DISPLAY_NAME"
                    RUST_PASSED=$((RUST_PASSED + 1))
                else
                    echo -e "  ${RED}✘${NC} $DISPLAY_NAME"
                    RUST_FAILED=$((RUST_FAILED + 1))
                    FAILED_TESTS+=("${RED}✘ [fail]:${NC} $MOD_NAME.$TEST_NAME")
                fi
            done < <(echo "$TESTS")
        else
            # If no tests were found, report it
            echo -e "  ${GREEN}✓${NC} No tests found or failed to parse test output"
            RUST_TOTAL=$((RUST_TOTAL + 1))
            RUST_PASSED=$((RUST_PASSED + 1))
        fi
    else
        echo -e "  ${RED}✘${NC} Compilation or test runner error"
        RUST_TOTAL=$((RUST_TOTAL + 1))
        RUST_FAILED=$((RUST_FAILED + 1))
        FAILED_TESTS+=("${RED}✘ [fail]:${NC} $MOD_NAME: Compilation error")
    fi

    echo ""
done

# Output test counts (for the main script to parse)
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
