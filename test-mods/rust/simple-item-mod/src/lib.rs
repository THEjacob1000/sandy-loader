use mod_api::{sandy_mod, ModInfo, SandyMod};
use rand::{thread_rng, Rng};
use std::collections::HashMap;

pub struct SimpleItemMod {
    id: String,
    name: String,
    version: String,
    description: String,

    // These data structures will help us test memory usage
    memory_usage_test_vec: Vec<String>,
    memory_usage_test_map: HashMap<String, i32>,
}

impl SimpleItemMod {
    pub fn new() -> Self {
        Self {
            id: "simple_item_mod".to_string(),
            name: "Simple Item Mod".to_string(),
            version: "1.0.0".to_string(),
            description: "A simple test mod that adds an item and consumes memory".to_string(),
            memory_usage_test_vec: Vec::new(),
            memory_usage_test_map: HashMap::new(),
        }
    }

    fn populate_test_data_structures(&mut self) {
        // Add 10,000 strings to the vector
        for i in 0..10_000 {
            self.memory_usage_test_vec.push(format!(
                "Test string #{} with some extra characters to use more memory: {}",
                i,
                generate_random_string(50)
            ));
        }

        // Add 10,000 entries to the map
        for i in 0..10_000 {
            self.memory_usage_test_map
                .insert(format!("Key-{}-{}", i, generate_random_string(20)), i);
        }

        log::info!("Populated test data structures with 10,000 entries each");
    }
}

impl SandyMod for SimpleItemMod {
    fn id(&self) -> &str {
        &self.id
    }

    fn initialize(&mut self) -> Result<(), String> {
        log::info!("Initializing Simple Item Mod");

        // This is where we would register items and blocks
        // For now, we'll just log that we're doing it
        log::info!("Registering test item and block");

        // Fill data structures with dummy data to test memory usage
        self.populate_test_data_structures();

        log::info!("Simple Item Mod initialized!");
        Ok(())
    }

    fn on_load(&mut self) -> Result<(), String> {
        log::info!("Simple Item Mod is loading!");
        // Any additional loading logic would go here
        Ok(())
    }

    fn on_unload(&mut self) -> Result<(), String> {
        log::info!("Simple Item Mod is unloading!");
        // Any cleanup logic would go here

        // Clear our data structures to free memory
        self.memory_usage_test_vec.clear();
        self.memory_usage_test_map.clear();

        Ok(())
    }
}

fn generate_random_string(length: usize) -> String {
    let mut rng = thread_rng();
    (0..length)
        .map(|_| (rng.gen_range(b'a'..=b'z') as char))
        .collect()
}

// This macro creates the necessary export functions for SandyLoader
sandy_mod!(SimpleItemMod);

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_mod_creation() {
        let mod_instance = SimpleItemMod::new();
        assert_eq!(mod_instance.id(), "simple_item_mod");
        assert_eq!(mod_instance.name, "Simple Item Mod");
    }
}
