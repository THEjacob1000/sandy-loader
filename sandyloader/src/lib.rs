//! SandyLoader - A memory-efficient Minecraft mod loader using Rust and JNI
//!
//! This is the main entry point for the SandyLoader library.

use jni::JNIEnv;
use jni::objects::{JClass, JString};
use jni::sys::jstring;

// Temporarily comment out module imports until we have the files created
// mod error;
// mod loader;
// mod memory;

/// Initialize the SandyLoader from Java
#[unsafe(no_mangle)]
pub extern "system" fn Java_com_sandyloader_SandyLoader_initialize(
    mut env: JNIEnv,
    _class: JClass,
    config_path: JString,
) -> jstring {
    // Convert the Java string to a Rust string
    let config_path: String = match env.get_string(&config_path) {
        Ok(s) => s.into(),
        Err(_) => {
            return env
                .new_string("Error: Couldn't get config path")
                .unwrap()
                .into_raw();
        }
    };

    // Placeholder for actual initialization logic
    let result = format!("SandyLoader initialized with config at: {}", config_path);

    // Return a jstring
    env.new_string(result).unwrap().into_raw()
}

/// Version information for SandyLoader
pub fn version() -> &'static str {
    env!("CARGO_PKG_VERSION")
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_version() {
        assert!(!version().is_empty());
    }
}
