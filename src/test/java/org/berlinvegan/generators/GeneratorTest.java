package org.berlinvegan.generators;

import org.junit.Ignore;
import org.junit.Test;

import static org.junit.Assert.assertTrue;

public class GeneratorTest {
    @Test
    @Ignore
    public void testSetRatingFromWebsite() throws Exception {
        Rating rating = Generator.getRatingFromWebsite("http://www.berlin-vegan.de/berlin/restaurantkritiken/chay-viet");
        assertTrue(rating.getNumber() > 29);
    }
}
