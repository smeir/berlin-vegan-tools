package org.berlinvegan.generators;

import com.google.gson.Gson;
import org.junit.Ignore;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.TemporaryFolder;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Map;

/**
 * Date: 20.07.13
 * Time: 11:47
 */
public class MapGeneratorTest {
    @Rule
    public TemporaryFolder tempFolder = new TemporaryFolder();
    @Test
    public void testGenerateMap() throws Exception {
        final MapGenerator generator = new MapGenerator();
        final String outputDir = tempFolder.getRoot().getAbsolutePath();
        WebsiteGenerator.setOutputDir(outputDir);
        final ArrayList<Restaurant> restaurants = new ArrayList<Restaurant>();
        Restaurant restaurant = new Restaurant("name1", "Kreuzberg", "52.49905", "13.42999", 2);
        restaurants.add(restaurant);
        restaurant = new Restaurant("name2", "Mitte/Wedding", "52.48905", "13.43999", 2);
        restaurants.add(restaurant);
        generator.generateMap("de", restaurants);
    }

    private ArrayList<String> constructParameters() {
        final String outputDir = tempFolder.getRoot().getAbsolutePath();
        final ArrayList<String> parameters = new ArrayList<String>();
        parameters.add(WebsiteGenerator.OUTPUT_DIR_OPTION);
        parameters.add(outputDir);
        return parameters;
    }


}
