// test-mods/rust/simple-item-mod/src/lib.rs
use mod_api::{sandy_mod, ModInfo, SandyMod};

pub struct simple_item_mod {
    id: String,
}

impl simple_item_mod {
    pub fn new() -> Self {
        Self {
            id: "simple-item-mod".to_string(),
        }
    }
}

impl SandyMod for simple_item_mod {
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

sandy_mod!(simple_item_mod);

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_id() {
        let mod_instance = simple_item_mod::new();
        assert_eq!(mod_instance.id(), "simple-item-mod");
    }
}
