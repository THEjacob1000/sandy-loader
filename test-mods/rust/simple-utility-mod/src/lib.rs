use mod_api::{sandy_mod, ModInfo, SandyMod};
use std::collections::HashMap;
use std::sync::{Arc, Mutex};
use std::time::{Duration, Instant};

/// A very simple utility mod that provides useful functions to other mods
/// This can be used as a simple test case for the SandyLoader project
pub struct SimpleUtilityMod {
    id: String,
    name: String,
    version: String,
    description: String,

    // A cache to demonstrate memory usage
    // Using Arc<Mutex<>> to allow sharing between threads safely
    player_data_cache: Arc<Mutex<HashMap<String, PlayerData>>>,
}

impl SimpleUtilityMod {
    pub fn new() -> Self {
        Self {
            id: "simple_utility_mod".to_string(),
            name: "Simple Utility Mod".to_string(),
            version: "1.0.0".to_string(),
            description: "A simple utility mod that provides useful functions".to_string(),
            player_data_cache: Arc::new(Mutex::new(HashMap::new())),
        }
    }

    /// Store player data in our cache
    pub fn store_player_data(&self, player_uuid: &str, key: &str, value: &str) {
        let mut cache = self.player_data_cache.lock().unwrap();

        let player_data = cache
            .entry(player_uuid.to_string())
            .or_insert_with(PlayerData::new);

        player_data.set_data(key, value);
    }

    /// Get player data from our cache
    pub fn get_player_data(&self, player_uuid: &str, key: &str) -> Option<String> {
        let cache = self.player_data_cache.lock().unwrap();

        cache
            .get(player_uuid)
            .and_then(|player_data| player_data.get_data(key))
    }

    /// Clear player data when they log out to prevent memory leaks
    pub fn clear_player_data(&self, player_uuid: &str) {
        let mut cache = self.player_data_cache.lock().unwrap();
        cache.remove(player_uuid);
    }

    /// Register commands (simulated)
    fn register_commands(&self) {
        log::info!("Registering utility commands");
        // This would normally register commands, but we're just simulating
    }
}

impl SandyMod for SimpleUtilityMod {
    fn id(&self) -> &str {
        &self.id
    }

    fn initialize(&mut self) -> Result<(), String> {
        log::info!("Initializing Simple Utility Mod");

        // Register our utility commands and event handlers
        self.register_commands();

        log::info!("Simple Utility Mod initialized!");
        Ok(())
    }

    fn on_load(&mut self) -> Result<(), String> {
        log::info!("Simple Utility Mod is loading!");
        Ok(())
    }

    fn on_unload(&mut self) -> Result<(), String> {
        log::info!("Simple Utility Mod is unloading!");

        // Clear all player data to prevent memory leaks
        let mut cache = self.player_data_cache.lock().unwrap();
        cache.clear();

        Ok(())
    }
}

/// Simple struct to store player-specific data
struct PlayerData {
    data_map: HashMap<String, String>,
    last_accessed: Instant,
}

impl PlayerData {
    fn new() -> Self {
        Self {
            data_map: HashMap::new(),
            last_accessed: Instant::now(),
        }
    }

    fn set_data(&mut self, key: &str, value: &str) {
        self.data_map.insert(key.to_string(), value.to_string());
        self.last_accessed = Instant::now();
    }

    fn get_data(&self, key: &str) -> Option<String> {
        self.data_map.get(key).cloned()
    }
}

// This macro creates the necessary export functions for SandyLoader
sandy_mod!(SimpleUtilityMod);

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_player_data() {
        let mod_instance = SimpleUtilityMod::new();

        let player_uuid = "test-uuid-123";
        let key = "test-key";
        let value = "test-value";

        // Initially no data
        assert_eq!(mod_instance.get_player_data(player_uuid, key), None);

        // Store data
        mod_instance.store_player_data(player_uuid, key, value);

        // Retrieve data
        assert_eq!(
            mod_instance.get_player_data(player_uuid, key),
            Some(value.to_string())
        );

        // Clear data
        mod_instance.clear_player_data(player_uuid);

        // Data should be gone
        assert_eq!(mod_instance.get_player_data(player_uuid, key), None);
    }
}
