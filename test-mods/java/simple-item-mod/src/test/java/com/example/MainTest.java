// test-mods/java/simple-item-mod/src/test/java/com/example/MainTest.java
package com.example;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class MainTest {
    @Test
    public void testGetModName() {
        assertEquals("simple-item-mod", Main.getModName());
    }
}