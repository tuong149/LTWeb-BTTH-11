package vn.iotstar.config;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import vn.iotstar.util.ConfigLoader_24110375;

import java.util.HashMap;
import java.util.Map;

public class JpaConfig_24110375 {
    private static EntityManagerFactory factory;

    public static synchronized EntityManager getEntityManager() {
        if (factory == null || !factory.isOpen()) {
            Map<String, String> properties = new HashMap<>();
            
            properties.put("javax.persistence.jdbc.driver", ConfigLoader_24110375.get("DB_DRIVER"));
            properties.put("javax.persistence.jdbc.url", ConfigLoader_24110375.get("DB_URL"));
            properties.put("javax.persistence.jdbc.user", ConfigLoader_24110375.get("DB_USER"));
            properties.put("javax.persistence.jdbc.password", ConfigLoader_24110375.get("DB_PASSWORD"));
            
            String dialect = ConfigLoader_24110375.get("DB_DIALECT", "");
            if (dialect != null && !dialect.isEmpty()) {
                properties.put("hibernate.dialect", dialect);
            }

            factory = Persistence.createEntityManagerFactory("KTQT_PU", properties);
        }
        return factory.createEntityManager();
    }

    public static synchronized void closeFactory() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}

