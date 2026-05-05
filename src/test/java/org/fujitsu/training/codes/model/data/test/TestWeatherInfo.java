package org.fujitsu.training.codes.model.data.test;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.fujitsu.training.codes.model.data.WeatherInfo;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class TestWeatherInfo {

    private WeatherInfo rec;

    @BeforeEach
    public void setup() {
        rec = new WeatherInfo();
    }

    @AfterEach
    public void teardown() {
        rec = null;
    }

    @Test
    public void testWeatherInfoSettersAndGetters() {
        rec.setTemperature(28.5);
        rec.setWeatherDescription("Mainly clear");
        rec.setWeatherCode(1);
        rec.setWindSpeed(12.6);
        rec.setIsDay(1);

        assertEquals(28.5, rec.getTemperature());
        assertEquals("Mainly clear", rec.getWeatherDescription());
        assertEquals(1, rec.getWeatherCode());
        assertEquals(12.6, rec.getWindSpeed());
        assertEquals(1, rec.getIsDay());
    }
}