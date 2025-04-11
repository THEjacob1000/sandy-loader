# SandyLoader: Low-Memory Minecraft Modding Framework

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
![Status](https://img.shields.io/badge/Status-In%20Development-yellow)

## 🚀 Project Overview

SandyLoader is an ambitious project to refactor Minecraft mods from "All The Mods 10" into Rust to dramatically reduce memory usage, allowing modded Minecraft to run on systems with less than 8GB RAM.

**Key Features:**

- Native code performance with Rust
- JNI integration with the Minecraft ecosystem
- Custom modloader extensions for Forge/Fabric
- Memory-optimized versions of popular mods
- Extensive profiling and optimization tools

## 📋 Project Status

This project is in early development. We are currently in the research and planning phase.

- ✅ Project planning
- ⏳ Environment analysis
- ⏳ Technical investigation
- 🔜 Mod architecture analysis
- 🔜 Development environment setup

## 🔍 The Problem

Modded Minecraft (especially larger packs like All The Mods) has become increasingly memory-hungry, making it inaccessible to players with budget hardware. This project aims to make modded Minecraft more accessible by addressing the root cause: inefficient memory usage in Java-based mods.

## 💡 Our Approach

Instead of just optimizing existing Java code, we're taking a more radical approach:

1. Identify the most memory-intensive mods
2. Reimplement core functionality in Rust using JNI
3. Create a custom modloader extension to bridge the Java and Rust ecosystems
4. Optimize shared resources across mods
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

1. Profiling ATM10 to identify memory usage patterns
2. Researching Rust-JNI integration approaches
3. Analyzing the architecture of key memory-intensive mods
4. Building proof-of-concept prototypes

## 📥 Installation

*Note: There is no installable version yet. This section will be updated when alpha builds become available.*

## 🎮 Featured Modpack

**"ATM10: Sandstorm"** - Our first optimized modpack based on "All The Mods 10" but designed to run on systems with less than 8GB RAM. This modpack will feature the first set of memory-optimized mods using our SandyLoader technology.

## 📊 Target Performance

Our goal is to reduce memory requirements by 40-60% compared to the original Java implementations, allowing All The Mods 10 to run with less than 8GB RAM.

## 📚 Documentation

- [Project Plan](PROJECTPLAN.md)
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
- [Discord Server](https://discord.gg/sandyLoader) (coming soon): For community discussions

---

*SandyLoader is not affiliated with Mojang, Microsoft, or the "All The Mods" team. Minecraft is a trademark of Mojang Studios.*
