# SandyLoader: Low-Memory Minecraft Modding Framework

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
![Status](https://img.shields.io/badge/Status-In%20Development-yellow)

## 🚀 Project Overview

SandyLoader is an ambitious project to create a Rust-based mod loader for Minecraft that dramatically reduces memory usage. By refactoring critical mod functionality from Java to Rust, SandyLoader enables modded Minecraft to run on systems with less than 8GB RAM.

**Key Features:**

- Native code performance with Rust
- JNI integration with the Minecraft ecosystem
- Custom modloader extensions for Forge/Fabric
- Memory optimization architecture
- Comprehensive profiling and optimization tools

## 📋 Project Status

This project is in early development. We are currently in the research and planning phase.

- ✅ Project planning
- ⏳ Environment analysis
- ⏳ Technical investigation
- 🔜 Mod architecture analysis
- 🔜 Development environment setup

## 🔍 The Problem

Modded Minecraft (especially larger packs like All The Mods) has become increasingly memory-hungry, making it inaccessible to players with budget hardware. This project aims to make modded Minecraft more accessible by addressing the root cause: inefficient memory usage in Java-based mods and modloaders.

## 💡 Our Approach

Instead of just optimizing existing Java code, we're taking a more radical approach:

1. Build a Rust-based mod loader and memory management system
2. Create a JNI bridge for seamless Java/Rust interoperability
3. Develop a common API for creating memory-efficient Rust mods
4. Provide tools for analyzing and profiling Minecraft memory usage
5. Maintain compatibility with the existing modding ecosystem

## 🗺️ Roadmap

See our [detailed project plan](PROJECTPLAN.md) for the complete roadmap. Key milestones include:

1. **Research & Planning** (2-4 weeks)
2. **Development Environment Setup** (2-3 weeks)
3. **Core Infrastructure Development** (1-2 months)
4. **Individual Mod Refactoring** (3-6 months per tier)
5. **Integration & Optimization** (2-3 months)
6. **Testing & Release** (1-2 months)

## 🛠️ Getting Involved

We welcome contributions from developers with experience in:

- Minecraft modding (Forge/Fabric)
- Rust programming
- JNI/cross-language integration
- Memory optimization
- Java performance profiling

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute.

## 🧪 Current Development Focus

We're currently focusing on:

1. Building the core SandyLoader architecture
2. Developing memory profiling tools
3. Creating the JNI bridge between Java and Rust
4. Designing the mod API for Rust-based mods

## 📥 Installation

*Note: There is no installable version yet. This section will be updated when alpha builds become available.*

## 📊 Target Performance

Our goal is to reduce memory requirements by 40-60% compared to the original Java implementations, allowing modpack experiences like "All The Mods 10" to run with less than 8GB RAM.

## 📚 Documentation

- [Project Plan](PROJECTPLAN.md)
- [Contributing Guide](CONTRIBUTING.md)
- [Technical Architecture](docs/ARCHITECTURE.md) (coming soon)
- [Development Setup](docs/DEVSETUP.md) (coming soon)
- [Mod Porting Guide](docs/MODPORTING.md) (coming soon)

## ⚖️ License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Related Projects

- [Feather](https://github.com/feather-rs/feather) - Minecraft server implementation in Rust
- [Minecraft Rust JNI Examples](https://github.com/minecraft-rs/rust-jni-examples) - Examples of using Rust with Java in Minecraft

## 📞 Contact

- GitHub Issues: For bug reports and feature requests
- [Discord Server](https://discord.gg/d2ChakjBjR): For community discussions

---

*SandyLoader is not affiliated with Mojang, Microsoft, or the "All The Mods" team. Minecraft is a trademark of Mojang Studios.*
