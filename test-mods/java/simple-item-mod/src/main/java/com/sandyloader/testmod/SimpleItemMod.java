package com.sandyloader.testmod;

import net.minecraft.item.Item;
import net.minecraft.item.ItemGroup;
import net.minecraft.util.Identifier;
import net.minecraft.util.registry.Registry;
import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.item.v1.FabricItemSettings;
import net.fabricmc.fabric.api.object.builder.v1.block.FabricBlockSettings;
import net.minecraft.block.Block;
import net.minecraft.block.Material;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

public class SimpleItemMod implements ModInitializer {
    public static final String MOD_ID = "simple_item_mod";
    public static final Logger LOGGER = LogManager.getLogger(MOD_ID);
    
    // This will be our test item
    public static final Item TEST_ITEM = new Item(new FabricItemSettings().group(ItemGroup.MISC));
    
    // This will be our test block
    public static final Block TEST_BLOCK = new Block(FabricBlockSettings.of(Material.STONE).strength(4.0f));
    
    // These data structures will help us test memory usage
    private final List<String> memoryUsageTestList = new ArrayList<>();
    private final Map<String, Integer> memoryUsageTestMap = new HashMap<>();
    private final Random random = new Random();
    
    @Override
    public void onInitialize() {
        LOGGER.info("Initializing Simple Item Mod");
        
        // Register our item
        Registry.register(
            Registry.ITEM,
            new Identifier(MOD_ID, "test_item"),
            TEST_ITEM
        );
        
        // Register our block
        Registry.register(
            Registry.BLOCK,
            new Identifier(MOD_ID, "test_block"),
            TEST_BLOCK
        );
        
        // Register the block's item form
        Registry.register(
            Registry.ITEM,
            new Identifier(MOD_ID, "test_block"),
            new BlockItem(TEST_BLOCK, new FabricItemSettings().group(ItemGroup.BUILDING_BLOCKS))
        );
        
        // Fill data structures with dummy data to test memory usage
        populateTestDataStructures();
        
        LOGGER.info("Simple Item Mod initialized!");
    }
    
    private void populateTestDataStructures() {
        // Add 10,000 strings to the list
        for (int i = 0; i < 10_000; i++) {
            memoryUsageTestList.add("Test string #" + i + " with some extra characters to use more memory: " + 
                                    generateRandomString(50));
        }
        
        // Add 10,000 entries to the map
        for (int i = 0; i < 10_000; i++) {
            memoryUsageTestMap.put("Key-" + i + "-" + generateRandomString(20), i);
        }
        
        LOGGER.info("Populated test data structures with 10,000 entries each");
    }
    
    private String generateRandomString(int length) {
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            char c = (char) (random.nextInt(26) + 'a');
            sb.append(c);
        }
        return sb.toString();
    }
    
    // Missing class added here
    public static class BlockItem extends net.minecraft.item.BlockItem {
        public BlockItem(Block block, Settings settings) {
            super(block, settings);
        }
    }
}