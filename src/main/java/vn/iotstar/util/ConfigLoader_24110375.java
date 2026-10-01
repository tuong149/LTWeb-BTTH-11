package vn.iotstar.util;

import java.io.InputStream;
import java.util.Properties;

public class ConfigLoader_24110375 {
    private static final Properties properties = new Properties();

    static {
        try (InputStream input = ConfigLoader_24110375.class.getClassLoader().getResourceAsStream(".env")) {
            if (input != null) {
                properties.load(input);
            } else {
                System.out.println("CẢNH BÁO: Không tìm thấy file .env trong thư mục resources!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String get(String key) {
        return properties.getProperty(key);
    }

    public static String get(String key, String defaultValue) {
        return properties.getProperty(key, defaultValue);
    }
}

