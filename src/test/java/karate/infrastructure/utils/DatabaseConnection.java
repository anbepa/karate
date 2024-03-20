package karate.infrastructure.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import java.util.Collections;
import java.util.List;
import java.util.Map;

public class DatabaseConnection {
    private static final Logger logger = LoggerFactory.getLogger(DatabaseConnection.class);

    private final JdbcTemplate jdbc;

    public DatabaseConnection(Map<String, Object> config) {
        try {
            String url = (String) config.get("url");
            String username = (String) config.get("username");
            String password = (String) config.get("password");
            String driver = (String) config.get("driverClassName");
            DriverManagerDataSource dataSource = new DriverManagerDataSource();
            dataSource.setDriverClassName(driver);
            dataSource.setUrl(url);
            dataSource.setUsername(username);
            dataSource.setPassword(password);
            jdbc = new JdbcTemplate(dataSource);
            logger.info("Conexion exitosa", url);
        } catch (Exception e) {
            logger.error("Error al establecer la conexión: {}", e.getMessage());
            throw new RuntimeException("Error al establecer la conexión", e);
        }
    }


    public Object readValue(String query) {
        return jdbc.queryForObject(query, Object.class);
    }

    public Map<String, Object> readRow(String query) {
        return jdbc.queryForMap(query);
    }

    public List<Map<String, Object>> readRows(String query) {
        List<Map<String, Object>> result;
        try {
            result = jdbc.queryForList(query);
        } catch (EmptyResultDataAccessException e) {
            result = Collections.emptyList(); // Devuelve una lista vacía si no se encuentran datos
        }
        return result;
    }

    public int update(String query) {
        return jdbc.update(query);
    }

    // DELETE RECORD of a table
    public Boolean delete(Integer id, String query) {

        return jdbc.update(query, id) > 2;
    }


}
