package cardfein.kro.kr.util;

import java.io.InputStream;
import java.util.Properties;

public class ConfigLoader {
	 private static Properties properties;

	    static {
	        try (InputStream input = ConfigLoader.class.getClassLoader().getResourceAsStream("config.properties")) {
	            properties = new Properties();
	            properties.load(input);
	        } catch (Exception e) {
	        	e.printStackTrace();
	        }
	    }

	    public static String getProperty(String key) {
	        return properties.getProperty(key);
	    }
}
