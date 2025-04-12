package com.sandyloader.testmod;

import net.fabricmc.api.ModInitializer;
import net.minecraft.entity.player.PlayerEntity;
import net.minecraft.text.Text;
import net.minecraft.util.Identifier;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * A very simple utility mod that provides useful functions to other mods
 * This can be used as a simple test case for the SandyLoader project
 */
public class SimpleUtilityMod implements ModInitializer {
    public static final String MOD_ID = "simple_utility_mod";
    public static final Logger LOGGER = LogManager.getLogger(MOD_ID);
    
    // A cache to demonstrate memory usage
    private static final Map<UUID, PlayerData> PLAYER_DATA_CACHE = new HashMap<>();
    
    @Override
    public void onInitialize() {
        LOGGER.info("Initializing Simple Utility Mod");
        
        // Register our utility commands and event handlers
        registerCommands();
        
        LOGGER.info("Simple Utility Mod initialized!");
    }
    
    private void registerCommands() {
        LOGGER.info("Registering utility commands");
        // This would normally register commands, but we're just simulating
    }
    
    /**
     * Utility method to send a formatted message to a player
     * Other mods could call this method
     */
    public static void sendFormattedMessage(PlayerEntity player, String message) {
        if (player == null || message == null) {
            return;
        }
        
        player.sendMessage(Text.literal("§b[Utility]§r " + message));
    }
    
    /**
     * Store player data in our cache
     */
    public static void storePlayerData(PlayerEntity player, String key, String value) {
        PlayerData data = PLAYER_DATA_CACHE.computeIfAbsent(player.getUuid(), uuid -> new PlayerData());
        data.setData(key, value);
    }
    
    /**
     * Get player data from our cache
     */
    public static String getPlayerData(PlayerEntity player, String key) {
        PlayerData data = PLAYER_DATA_CACHE.get(player.getUuid());
        if (data == null) {
            return null;
        }
        return data.getData(key);
    }
    
    /**
     * Clear player data when they log out to prevent memory leaks
     */
    public static void clearPlayerData(UUID playerUuid) {
        PLAYER_DATA_CACHE.remove(playerUuid);
    }
    
    /**
     * Simple class to store player-specific data
     */
    private static class PlayerData {
        private final Map<String, String> dataMap = new HashMap<>();
        
        public void setData(String key, String value) {
            dataMap.put(key, value);
        }
        
        public String getData(String key) {
            return dataMap.get(key);
        }
    }
}