// test-mods/rust/simple-item-mod/src/lib.rs
use mod_api::{SandyMod, sandy_mod};

pub struct SimpleItemMod {
    id: String,
}

impl SimpleItemMod {
    pub fn new() -> Self {
        Self {
            id: "simple-item-mod".to_string(),
        }
    }
}

impl SandyMod for SimpleItemMod {
    fn id(&self) -> &str {
        &self.id
    }

    fn initialize(&mut self) -> Result<(), String> {
        println!("Initializing simple-item-mod!");
        Ok(())
    }

    fn on_load(&mut self) -> Result<(), String> {
        println!("simple-item-mod loaded!");
        Ok(())
    }

    fn on_unload(&mut self) -> Result<(), String> {
        println!("simple-item-mod unloaded!");
        Ok(())
    }
}

sandy_mod!(SimpleItemMod);

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_id() {
        let mod_instance = SimpleItemMod::new();
        assert_eq!(mod_instance.id(), "simple-item-mod");
    }
}
