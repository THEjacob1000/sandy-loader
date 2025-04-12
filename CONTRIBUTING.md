# Contributing to SandyLoader

Thank you for your interest in contributing to SandyLoader! This document provides guidelines and instructions for contributing to this project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Environment](#development-environment)
- [Project Structure](#project-structure)
- [Contribution Workflow](#contribution-workflow)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Documentation](#documentation)
- [Issue and Pull Request Process](#issue-and-pull-request-process)

## Code of Conduct

This project adheres to a Code of Conduct that all contributors are expected to follow. By participating, you are expected to uphold this code. Please report unacceptable behavior to the project maintainers.

## Getting Started

1. **Fork the repository**: Create your own fork of the project.
2. **Clone your fork**: `git clone https://github.com/your-username/sandy-loader.git`
3. **Add the upstream remote**: `git remote add upstream https://github.com/THEjacob1000/sandy-loader.git`

## Development Environment

### Prerequisites

- Rust (latest stable version)
- Java Development Kit (JDK) 17 or later
- Minecraft development environment (for testing)
- Cargo and the Rust toolchain
- Git

### Setup

1. Install Rust using [rustup](https://rustup.rs/)
2. Install a JDK (we recommend OpenJDK 17)
3. Clone the repository and its submodules
4. Run `cargo build` to compile the project

## Project Structure

The project is organized as a Rust workspace with multiple crates:

- `sandyloader`: Main crate for the mod loader
- `jni-bridge`: Handles communication between Java and Rust
- `memory-manager`: Manages memory optimization
- `mod-api`: API for creating Rust-based mods
- `tools`: Contains development and profiling tools

## Contribution Workflow

1. **Create a branch**: Create a branch for your work with a descriptive name
2. **Make your changes**: Implement your feature or fix
3. **Write tests**: Add tests for your changes
4. **Update documentation**: Document your changes
5. **Commit your changes**: Use clear, descriptive commit messages
6. **Push to your fork**: `git push origin your-branch-name`
7. **Create a Pull Request**: Submit a PR to the main repository

## Coding Standards

### Rust Code

- Follow the [Rust API Guidelines](https://rust-lang.github.io/api-guidelines/)
- Use `cargo fmt` to format your code
- Run `cargo clippy` to catch common mistakes
- Write comments for public API functions and complex logic
- Aim for clear, idiomatic Rust code

### Java Code

- Follow standard Java conventions
- Use meaningful variable and method names
- Document public methods with Javadoc comments

## Testing

- Write unit tests for all new functionality
- Ensure all tests pass before submitting a PR
- Consider adding integration tests for significant features
- Test your changes in a real Minecraft environment when applicable

## Documentation

- Document all public APIs
- Update README.md and other documentation files as needed
- Add comments explaining complex or non-obvious code
- Create examples for new features

## Issue and Pull Request Process

### Issues

- Use the issue templates when available
- Clearly describe the problem or feature request
- Include steps to reproduce for bugs
- Specify the versions of relevant software

### Pull Requests

- Link to any related issues
- Describe the changes you've made
- Include screenshots for UI changes
- Respond to review comments promptly
- Be patient and respectful during the review process

## Areas to Contribute

We welcome contributions in several areas:

- Core mod loader infrastructure
- Memory optimization techniques
- JNI bridge improvements
- Profiling and analysis tools
- Documentation and examples
- Testing and bug fixes

## Recognition

All contributors will be recognized in our CONTRIBUTORS.md file. We value every contribution, no matter how small!

Thank you for helping make SandyLoader better!
