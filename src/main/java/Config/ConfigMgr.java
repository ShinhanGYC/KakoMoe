package Config;

import java.io.InputStream;
import java.util.Properties;

public class ConfigMgr {
    private static Properties properties = new Properties();

    static {
        try (InputStream input = ConfigMgr.class.getClassLoader().getResourceAsStream("/Config/config.properties")) {
            if (input == null) {
                throw new RuntimeException("Unable to find config.properties");
            }
            properties.load(input);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to load configuration properties", e);
        }
    }

    public static String getProperty(String key) {
        return properties.getProperty(key);
    }
}