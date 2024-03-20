package karate.infrastructure.utils;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.LogManager;

public class UpdateObligationDate {

    private final String PROPERTIES_FILE_PATH;
    private static final String DATE_FORMAT = "yyyy-MM-dd";
    private static final int MONTHS_TO_SUBTRACT_CREATE_AT = 4;
    private static final int DAYS_TO_SUBTRACT_NET_DATE = 9;
    private static final int DAYS_TO_SUBTRACT_TOTAL_DATE = 10;
    private static final Logger logger = LoggerFactory.getLogger(UpdateObligationDate.class);


    public UpdateObligationDate(String PROPERTIES_FILE_PATH) {
        this.PROPERTIES_FILE_PATH = PROPERTIES_FILE_PATH;
    }

    public void performUpdate() {
        try {
            // Obtener la fecha actual
            Date currentDate = new Date();
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(currentDate);

            // Restar el número de meses para create_at
            calendar.add(Calendar.MONTH, -MONTHS_TO_SUBTRACT_CREATE_AT);
            Date createAtDate = calendar.getTime();

            // Restar el número de días para net_date
            calendar.setTime(currentDate);
            calendar.add(Calendar.DAY_OF_MONTH, -DAYS_TO_SUBTRACT_NET_DATE);
            Date netDate = calendar.getTime();

            // Restar el número de días para total_date
            calendar.setTime(currentDate);
            calendar.add(Calendar.DAY_OF_MONTH, -DAYS_TO_SUBTRACT_TOTAL_DATE);
            Date totalDate = calendar.getTime();

            // Formatear las nuevas fechas
            SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
            String newCreateAt = sdf.format(createAtDate);
            String newNetDate = sdf.format(netDate);
            String newTotalDate = sdf.format(totalDate);

            List<String> lines = Files.readAllLines(Paths.get(PROPERTIES_FILE_PATH), StandardCharsets.UTF_8);

            for (int i = 0; i < lines.size(); i++) {
                String line = lines.get(i);
                if (line.startsWith("obligation=")) {
                    String newLine = "obligation=UPDATE schsaf.tbl_obligations SET principal_balance = 10000, created_at='" + newCreateAt +
                            "', net_due_date='" + newNetDate + "', total_due_date='" + newTotalDate + "', accrued_amortized=0, accrued_remunerative=0, accrued_moratorium=0, remunerative_balance=205473.1, moratorium_balance=42.34, state='EXPIRED' WHERE id = 15177";
                    lines.set(i, newLine);
                    break;
                }
            }

            Files.write(Paths.get(PROPERTIES_FILE_PATH), lines, StandardCharsets.UTF_8);

            logger.info("Los campos create_at, net_date y total_date se han actualizado con éxito en el archivo {}", PROPERTIES_FILE_PATH);
        } catch (IOException e) {
            logger.error("Error al actualizar los campos create_at, net_date y total_date en el archivo {}", PROPERTIES_FILE_PATH, e);
        }
    }
}
