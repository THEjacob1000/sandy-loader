// test-mods/rust/simple-utility-mod/src/lib.rs
use mod_api::{sandy_mod, ModInfo, SandyMod};

pub struct simple_utility_mod {
    id: String,
}

impl simple_utility_mod {
    pub fn new() -> Self {
        Self {
            id: "simple-utility-mod".to_string(),
        }
    }
}

impl SandyMod for simple_utility_mod {
    fn id(&self) -> &str {
        &self.id
    }

    fn initialize(&mut self) -> Result<(), String> {
        println!("Initializing simple-utility-mod!");
        Ok(())
    }

    fn on_load(&mut self) -> Result<(), String> {
        println!("simple-utility-mod loaded!");
        Ok(())
    }

    fn on_unload(&mut self) -> Result<(), String> {
        println!("simple-utility-mod unloaded!");
        Ok(())
    }
}

sandy_mod!(simple_utility_mod);

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_id() {
        let mod_instance = simple_utility_mod::new();
        assert_eq!(mod_instance.id(), "simple-utility-mod");
    }
}
