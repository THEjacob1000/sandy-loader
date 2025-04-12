//! Mod API for SandyLoader
//!
//! This crate provides the API for creating Rust-based Minecraft mods
//! that can be loaded by SandyLoader.

/// Trait that all SandyLoader mods must implement
pub trait SandyMod {
    /// Get the ID of this mod
    fn id(&self) -> &str;

    /// Initialize the mod
    fn initialize(&mut self) -> Result<(), String>;

    /// Called when the mod is loaded
    fn on_load(&mut self) -> Result<(), String>;

    /// Called when the mod is unloaded
    fn on_unload(&mut self) -> Result<(), String>;
}

/// Information about a mod
#[derive(Debug, Clone)]
pub struct ModInfo {
    /// Unique ID of the mod
    pub id: String,

    /// Human-readable name of the mod
    pub name: String,

    /// Version of the mod
    pub version: String,

    /// Description of the mod
    pub description: String,
}

/// Helper macro for defining a SandyLoader mod
#[macro_export]
macro_rules! sandy_mod {
    ($mod_type:ty) => {
        #[unsafe(no_mangle)]
        pub extern "C" fn create_sandy_mod() -> *mut dyn $crate::SandyMod {
            let boxed = Box::new(<$mod_type>::new());
            Box::into_raw(boxed)
        }
    };
}

#[cfg(test)]
mod tests {
    use super::*;

    struct TestMod {
        id: String,
    }

    impl TestMod {
        fn new() -> Self {
            Self {
                id: "test-mod".to_string(),
            }
        }
    }

    impl SandyMod for TestMod {
        fn id(&self) -> &str {
            &self.id
        }

        fn initialize(&mut self) -> Result<(), String> {
            Ok(())
        }

        fn on_load(&mut self) -> Result<(), String> {
            Ok(())
        }

        fn on_unload(&mut self) -> Result<(), String> {
            Ok(())
        }
    }

    #[test]
    fn test_mod_trait() {
        let mut test_mod = TestMod::new();
        assert_eq!(test_mod.id(), "test-mod");
        assert!(test_mod.initialize().is_ok());
    }
}
