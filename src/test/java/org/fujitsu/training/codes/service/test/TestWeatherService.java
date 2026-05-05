package org.fujitsu.training.codes.service.test;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import org.fujitsu.training.codes.model.data.WeatherInfo;
import org.fujitsu.training.codes.service.WeatherService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class TestWeatherService {

    private WeatherService service;

    @BeforeEach
    public void setup() {
        service = new WeatherService();
    }

    @AfterEach
    public void teardown() {
        service = null;
    }

    @Test
    public void testGetCurrentWeatherNullLatitude() {
        WeatherInfo rec = service.getCurrentWeather(null, 120.3869);
        assertNull(rec);
    }

    @Test
    public void testGetCurrentWeatherNullLongitude() {
        WeatherInfo rec = service.getCurrentWeather(17.5747, null);
        assertNull(rec);
    }

    @Test
    public void testGetCurrentWeatherBothNull() {
        WeatherInfo rec = service.getCurrentWeather(null, null);
        assertNull(rec);
    }

    @Test
    public void testGetCurrentWeatherValidCoordinates() {
        WeatherInfo rec = assertDoesNotThrow(() ->
                service.getCurrentWeather(17.5747, 120.3869));

        assertNotNull(rec);
        assertNotNull(rec.getTemperature());
        assertNotNull(rec.getWeatherDescription());
        assertNotNull(rec.getWeatherCode());
        assertNotNull(rec.getWindSpeed());
        assertNotNull(rec.getIsDay());
    }
}